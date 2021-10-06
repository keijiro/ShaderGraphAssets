#include "Packages/jp.keijiro.noiseshader/Shader/ClassicNoise2D.hlsl"
#include "Packages/jp.keijiro.noiseshader/Shader/ClassicNoise3D.hlsl"
#include "Packages/jp.keijiro.noiseshader/Shader/SimplexNoise2D.hlsl"
#include "Packages/jp.keijiro.noiseshader/Shader/SimplexNoise3D.hlsl"

void ClassicNoise2D_float(float2 pos, out float value)
{
    value = ClassicNoise(pos);
}

void PeriodicNoise2D_float(float2 pos, float2 rep, out float value)
{
    value = PeriodicNoise(pos, rep);
}

void SimplexNoise2D_float(float2 pos, out float value, out float2 grad)
{
    float3 n = SimplexNoiseGrad(pos);
    grad = n.xy;
    value = n.z;
}

void ClassicNoise3D_float(float3 pos, out float value)
{
    value = ClassicNoise(pos);
}

void PeriodicNoise3D_float(float3 pos, float3 rep, out float value)
{
    value = PeriodicNoise(pos, rep);
}

void SimplexNoise3D_float(float3 pos, out float value, out float3 grad)
{
    float4 n = SimplexNoiseGrad(pos);
    grad = n.xyz;
    value = n.w;
}
