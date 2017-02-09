// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/Gazoline"
{
	Properties
	{
		_BumpMap("Normal Map", 2D) = "bump" {}
		_Color("Color1", Color) = (1,1,1,1)
		_Color2("Color2", Color) = (1,1,1,1)
		_Magnitude("Magnitude", Range(0, 1)) = 0.5
	}

	SubShader
	{
		Pass
		{

			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
				float4 tangent : TANGENT;
				float2 uv : TEXCOORD0;
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

			// vertex shader now also needs a per-vertex tangent vector.
			// in Unity tangents are 4D vectors, with the .w component used to
			// indicate direction of the bitangent vector.
			// we also need the texture coordinate.
			v2f vert(appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				half3 wNormal = UnityObjectToWorldNormal(v.normal);
				half3 wTangent = UnityObjectToWorldDir(v.tangent.xyz);
				// compute bitangent from cross product of normal and tangent
				half tangentSign = v.tangent.w * unity_WorldTransformParams.w;
				half3 wBitangent = cross(wNormal, wTangent) * tangentSign;
				// output the tangent space matrix
				o.tspace0 = half3(wTangent.x, wBitangent.x, wNormal.x);
				o.tspace1 = half3(wTangent.y, wBitangent.y, wNormal.y);
				o.tspace2 = half3(wTangent.z, wBitangent.z, wNormal.z);
				o.uv = v.uv;
				return o;

				//view direction and reflection vector are now computed per pixel, in the fragment function
			}

			sampler2D _BumpMap;
			fixed4 _Color;
			fixed4 _Color2;
			float _Magnitude;

			fixed4 frag(v2f i) : SV_Target
			{
				// sample the normal map, and decode from the Unity encoding
				half3 tnormal = UnpackNormal(tex2D(_BumpMap, i.uv));
				// transform normal from tangent to world space
				half3 worldNormal;
				worldNormal.x = dot(i.tspace0, tnormal);
				worldNormal.y = dot(i.tspace1, tnormal);
				worldNormal.z = dot(i.tspace2, tnormal);

				// compute view direction and reflection vector
				// per-pixel here
				half3 worldViewDir = normalize(UnityWorldSpaceViewDir(i.worldPos));
				half3 worldRefl = reflect(-worldViewDir, worldNormal);

				// sample the default reflection cubemap, using the reflection vector
				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, worldRefl);
				// decode cubemap data into actual color
				half3 skyColor = DecodeHDR(skyData, unity_SpecCube0_HDR);

				fixed4 c = _Color * i.uv.x + _Color2 * i.uv.y;
				c.rgb *= 1 - skyColor * _Magnitude;
				return c;
			}
			ENDCG
		}
	}
}
