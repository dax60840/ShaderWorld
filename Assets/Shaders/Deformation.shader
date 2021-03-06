﻿Shader "Custom/Deformation"
{
	Properties
	{
		_MainTex ("Noise Texture", 2D) = "white" {}
		_Tex("Texture", 2D) = "white" {}
		_Color("Color", Color) = (1, 1, 1, 1)
		_Amount("Amount", Range(0, 1)) = 0
		_Speed("Speed", Range(0, 20)) = 5
	}
	SubShader
	{
		Tags { "Queue" = "Transparent" }

		Pass
		{
			Blend One One
			//Blend SrcAlpha OneMinusSrcAlpha
			//Cull Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
			};

			struct v2f
			{
				float3 worldPos : TEXCOORD0;
				// these three vectors will hold a 3x3 rotation matrix
                // that transforms from tangent to world space
				half3 tspace0 : TEXCOORD1; // tangent.x, bitangent.x, normal.x
				half3 tspace1 : TEXCOORD2; // tangent.y, bitangent.y, normal.y
				half3 tspace2 : TEXCOORD3; // tangent.z, bitangent.z, normal.z
				// texture coordinate for the normal map
				float2 uv : TEXCOORD4;
                float4 pos : SV_POSITION;
			};

			sampler2D _MainTex;
			sampler2D _Tex;
			float4 _MainTex_ST;
			float4 _Color;
			float _Amount;
			float _Speed;
			float3 _localPos;
			
			v2f vert (appdata v)
			{
				v2f o;
				v.vertex.xyz += v.normal * tex2Dlod(_MainTex, float4(v.uv.xy, 0, 0)).a * _Amount * cos(_Time.x * _Speed);
				_localPos = v.vertex;
				o.pos = UnityObjectToClipPos(v.vertex);

				//reflection
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 wNormal = UnityObjectToWorldNormal(v.normal);
				half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 wBitangent = cross(wNormal, wTangent) * tangentSign;
				o.tspace0 = half3(wTangent.x, wBitangent.x, wNormal.x);
				o.tspace1 = half3(wTangent.y, wBitangent.y, wNormal.y);
				o.tspace2 = half3(wTangent.z, wBitangent.z, wNormal.z);
				o.uv = v.uv;

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{ 
				half3 tnormal = UnpackNormal(tex2D(_MainTex, i.uv));
				half3 worldNormal;
				worldNormal.x = dot(i.tspace0, tnormal);
				worldNormal.y = dot(i.tspace1, tnormal);
				worldNormal.z = dot(i.tspace2, tnormal);
				half3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
				half3 worldRefl = reflect(-worldViewDir, worldNormal);

				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldRefl);
				half3 skyColor = DecodeHDR(skyData, unity_SpecCube0_HDR);

				fixed4 mainCol = tex2D(_MainTex, i.uv) + 1;
				mainCol.a = log(1.8 + abs(_localPos));
				fixed4 col = mainCol * tex2D(_Tex, i.uv) *float4(skyColor, 1);
				col *= _Color;
				return col;
			}
			ENDCG
		}
	}
}
