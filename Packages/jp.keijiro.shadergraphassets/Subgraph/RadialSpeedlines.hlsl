float RadialSpeedlines
  (float2 UV, float Freq, float2 Thick, float2 Radius, float Seed)
{
    float2 npos = (UV - 0.5) * 2;

    // Polar coordinates
    float2 polar;
    polar.x = (atan2(npos.x, npos.y) / PI + 1) / 2;
    polar.y = length(npos);

    // Spoke number / parameter in spoke
    uint spoke = (uint)((polar.x + Seed) * Freq) * 4;
    float param = frac(polar.x * Freq) * 2 - 1;

    // Random number generator
    float r1 = Hash(spoke) * 2 - 1;
    float r2 = Hash(spoke + 1);
    float r3 = Hash(spoke + 2);

    // Spoke offset / width
    float offs = Thick.y * r1 * 0.95;
    float width = Thick.x * (1 - abs(offs)) * (1 - Thick.y * r2);

    // Extent toward outer ring
    float inner_ring = Radius.x + Radius.y * r3;
    width *= smoothstep(inner_ring, inner_ring + 1, polar.y);

    // Thresholding with pseudo antialiasing
    // Equivalent to [ abs(param + offs) <= width ] but with AA.
    float coeff = 1000;
    float pot = width * (1 + Freq / coeff) - abs(param + offs);
    float level = saturate(pot * coeff / Freq);

    return level;
}

void RadialSpeedlines_float
  (float2 UV, float Freq, float2 Thick, float2 Radius, float Seed, out float Out)
{
    Out = RadialSpeedlines(UV, Freq, Thick, Radius, Seed);
}

void RadialSpeedlinesX4_float
  (float2 UV, float Freq, float2 Thick, float2 Radius, float Seed, out float Out)
{
    float2 uvdx = ddx(UV) / 4;
    float2 uvdy = ddy(UV) / 4;

    float acc = 0;
    acc += RadialSpeedlines(UV              , Freq, Thick, Radius, Seed) * 2;
    acc += RadialSpeedlines(UV - uvdx - uvdy, Freq, Thick, Radius, Seed);
    acc += RadialSpeedlines(UV + uvdx - uvdy, Freq, Thick, Radius, Seed);
    acc += RadialSpeedlines(UV - uvdx + uvdy, Freq, Thick, Radius, Seed);
    acc += RadialSpeedlines(UV + uvdx + uvdy, Freq, Thick, Radius, Seed);
    Out = acc / 6;
}
