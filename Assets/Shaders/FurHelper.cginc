﻿#ifndef FUR_SHADER_HELPER
#define FUR_SHADER_HELPER

struct appdata
{
	float4 vertex : POSITION;
	float3 normal : NORMAL;
	float4 uv : TEXCOORD0;
};

struct v2f
{
	float2 uv : TEXCOORD0;
	float3 normal : TEXCOORD1;
	float4 vertex : SV_POSITION;
};

float _FurLength;
float _UVScale;
float4 _Gravity;

v2f vert(appdata v)
{
	v2f o;

	float3 P = v.vertex + (v.normal * _FurLength * FUR_OFFSET);

	float vGravity = mul(_Gravity, UNITY_MATRIX_MVP);
	float k = pow(FUR_OFFSET, 3);  // We use the pow function, so that only the tips of the hairs bend
							  // As layer goes from 0 to 1, so by using pow(..) function is still
							  // goes form 0 to 1, but it increases faster! exponentially
	P = P + vGravity*k;


	float3 aNormal = v.normal;
	aNormal.xyz += vGravity * k;
	float3 normal = normalize(mul(aNormal, UNITY_MATRIX_MVP)) * FUR_OFFSET;
	o.uv = v.uv * _UVScale;
	o.normal = normal;
	o.vertex = mul(UNITY_MATRIX_MVP, float4(P , 1.0));

	return o;
}

sampler2D _MainTex;
sampler2D _FurTex;
float4 _Color;

fixed4 frag(v2f i) : SV_Target
{
	float4 col = tex2D(_MainTex,  i.uv); // Fur Texture - alpha is VERY IMPORTANT!
	//col.a = col.a + 0.01 / FUR_OFFSET;
	col *= _Color;
	return col;
}
#endif