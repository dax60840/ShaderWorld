﻿Shader "Custom/AlphaMoveShader"
{
	SubShader
	{
		Tags
		{
			"Queue" = "Transparent"
		}
		
		Pass
		{

			Blend One One //SrcAlpha OneMinusSrcAlpha

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
				fixed4 col = fixed4(i.uv.x, i.uv.y, 0, 1 - i.uv.x);
				return col;
			}
			ENDCG
		}
	}
}
