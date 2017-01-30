// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'

Shader "Custom/WorldReflColor"
{
	Properties
	{
		_Color("Color", Color) = (1,1,1,1)
		_Magnitude("Magnitude", Range(0, 1)) = 0.5
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float3 normal : NORMAL;
			};

			struct v2f
			{
				half3 worldRefl : TEXCOORD0;
				float4 pos : SV_POSITION;
			};
			
			v2f vert (appdata v)
			{
				v2f o;
				o.pos = UnityObjectToClipPos(v.vertex);
				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				float3 worldViewDir = normalize(UnityWorldSpaceViewDir(worldPos));
				float3 worldNormal = UnityObjectToWorldNormal(v.normal);
				o.worldRefl = reflect(-worldViewDir, worldNormal);
				return o;
			}

			fixed4 _Color;
			float _Magnitude;
			
			fixed4 frag (v2f i) : SV_Target
			{
				// sample the default reflection cubemap, using the reflection vector
				half4 skyData = UNITY_SAMPLE_TEXCUBE(unity_SpecCube0, i.worldRefl);
				// decode cubemap data into actual color
				half3 skyColor = DecodeHDR(skyData, unity_SpecCube0_HDR);
				// output it!
				fixed4 c = _Color;
				c.rgb *= skyColor * _Magnitude;
				return c;
			}
			ENDCG
		}
	}
}
