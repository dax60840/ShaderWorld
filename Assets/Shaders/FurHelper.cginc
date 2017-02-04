// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'

#ifndef FUR_SHADER_HELPER
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

	float3 vGravity = mul(unity_WorldToObject, _Gravity);
	float k = pow(FUR_OFFSET, 3);
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

sampler2D _Disp;
float _Magnitude;
float _Speed;

fixed4 frag(v2f i) : SV_Target
{
	//Disp
	float2 distuv = float2(i.uv.x + _Time.x * _Speed, i.uv.y + _Time.x * _Speed);
	float2 disp = tex2D(_Disp, distuv.xy).xy;
	disp = ((disp * 2) - 1) * _Magnitude;

	float4 col = tex2D(_FurTex,  i.uv + disp * FUR_OFFSET); // Fur Texture - alpha is VERY IMPORTANT!
	col.a = tex2D(_MainTex, i.uv).a;
	col *= _Color;
	return col;
}
#endif
