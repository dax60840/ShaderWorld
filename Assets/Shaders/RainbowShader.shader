﻿Shader "Custom/RainbowShader"
{
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
		}
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
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;
			};

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = mul(UNITY_MATRIX_MVP, v.vertex);
				o.uv = v.uv;
				return o;
			}

			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = fixed4(i.uv.x, i.uv.y, 1, i.uv.y / i.uv.x);
				return col;
			}
			ENDCG
		}
	}
}
