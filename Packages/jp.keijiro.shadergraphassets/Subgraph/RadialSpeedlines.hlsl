float RadialSpeedlines(float2 UV, float Freq, float2 Thick, float2 Radius)
{
    float2 npos = (UV - 0.5) / sqrt(0.5);

    float2 polar;
    polar.x = (atan2(npos.x, npos.y) / PI + 1) / 2;
    polar.y = length(npos);

    uint seed = (uint)(polar.x * Freq) * 4;

    float param = frac(polar.x * Freq) * 2 - 1;

    float offs = (Hash(seed) - 0.5) * Thick.y;
    float width = Thick.x * (1 - Hash(seed + 1) * Thick.y) * (1 - abs(offs));
    float radius = saturate(Radius.x + (Hash(seed + 2) - 0.5) * Radius.y);

    width *= (polar.y - radius) / (1.001 - radius);
    width *= width <= 0 ? 100 : 1;

    return saturate((abs(param + offs) - width) * 1000 / Freq / polar.y);
}

void RadialSpeedlines_float
  (float2 UV, float Freq, float2 Thick, float2 Radius, out float Out)
{
    Out = RadialSpeedlines(UV, Freq, Thick, Radius);
}

void RadialSpeedlinesX4_float
  (float2 UV, float Freq, float2 Thick, float2 Radius, out float Out)
{
    float2 uvdx = ddx(UV) / 4;
    float2 uvdy = ddy(UV) / 4;

    float acc = 0;
    acc += RadialSpeedlines(UV              , Freq, Thick, Radius) * 2;
    acc += RadialSpeedlines(UV - uvdx - uvdy, Freq, Thick, Radius);
    acc += RadialSpeedlines(UV + uvdx - uvdy, Freq, Thick, Radius);
    acc += RadialSpeedlines(UV - uvdx + uvdy, Freq, Thick, Radius);
    acc += RadialSpeedlines(UV + uvdx + uvdy, Freq, Thick, Radius);
    Out = acc / 6;
}
