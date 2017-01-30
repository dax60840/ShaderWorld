Shader "Custom/Fur" 
{
	Properties 
	{
		_UVScale ("uv Scale", Range(0, 10)) = 1
		_FurLength ("Fur Length", Range(0, 2)) = 0.5
		_Color ("Color", Color) = (1,1,1,1)
		_MainTex ("Noise", 2D) = "white" {}
		_FurTex("Motif", 2D) = "white" {}
		_Gravity("Gravity", Vector) = (0.0, 0.0, 0.0, 0.0)
	}

	SubShader{

		Tags
		{
			"Queue" = "Transparent"
		}

		Pass
		{
			Blend Off
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.00
			#include "FurHelper.cginc"
			ENDCG
		}
			
		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.01
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.02
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.03
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.04
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.05
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.06
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.07
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.08
			#include "FurHelper.cginc"
			ENDCG
		}

		Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.09
			#include "FurHelper.cginc"
			ENDCG
		}

			Pass
		{
			Blend SrcAlpha OneMinusSrcAlpha
			ZWrite Off
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#include "UnityCG.cginc"
			#define FUR_OFFSET 0.1
			#include "FurHelper.cginc"
			ENDCG
		}
	}
}