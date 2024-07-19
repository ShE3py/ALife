/*
    Adapted from: https://mrob.com/pub/comp/xmorphia/ogl/index.html
    Originally from: http://pmneila.github.io/jsexp/grayscott/
    
    Licensed under the BSD three-clause license, which follows:

        Copyright (c) 2012-2013, P. M. Neila
        All rights reserved.

        Redistribution and use in source and binary forms, with or without
        modification, are permitted provided that the following conditions are met:

        * Redistributions of source code must retain the above copyright notice, this
          list of conditions and the following disclaimer.

        * Redistributions in binary form must reproduce the above copyright notice,
          this list of conditions and the following disclaimer in the documentation
          and/or other materials provided with the distribution.

        * Neither the name of the copyright holder nor the names of its
          contributors may be used to endorse or promote products derived from
          this software without specific prior written permission.

        THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
        AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
        IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
        DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
        FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
        DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
        SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
        CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
        OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
        OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

*/

#include "xmorphia.h"

#include <math.h>

#include "common/config.h"

static float permute(float x) {
    return fmodf(((x * 34.0) + 1.0) * x, 289.0);
}

static float snoise(float u, float v) {
    const float CX =  0.211324865405187;
    const float CY =  0.366025403784439;
    const float CZ = -0.577350269189626;
    const float CW =  0.024390243902439;
        
    const float dotI = (u + v) * CY;
    const float iu = floorf(u + dotI);
    const float iv = floorf(v + dotI);
    
    const float dotX0 = (iu + iv) * CX;
    const float x0u = u - iu + dotX0;
    const float x0v = v - iv + dotX0;
    
    const float i1u = (x0u > x0v) ? 1 : 0;
    const float i1v = (x0u > x0v) ? 0 : 1;
    
    const float x12x = x0u + CX - i1u;
    const float x12y = x0v + CX - i1v;
    const float x12z = x0u + CZ;
    const float x12w = x0v + CZ;
    
    const float imu = fmodf(iu, 289.0);
    const float imv = fmodf(iv, 289.0);
    
    const float p0x = permute(imv + 0.0);
    const float p0y = permute(imv + i1v);
    const float p0z = permute(imv + 1.0);
    
    const float px = permute(p0x + imu + 0.0);
    const float py = permute(p0y + imu + i1u);
    const float pz = permute(p0z + imu + 1.0);
    
    const float len2_x0 = (x0u * x0u) + (x0v * x0v);
    const float len2_x12_xy = (x12x * x12x) + (x12y * x12y);
    const float len2_x12_zw = (x12z * x12z) + (x12w * x12w);
    
    const float m1x = fmaxf(0.5 - len2_x0, 0.0);
    const float m1y = fmaxf(0.5 - len2_x12_xy, 0.0);
    const float m1z = fmaxf(0.5 - len2_x12_zw, 0.0);
    
    const float m2x = m1x * m1x;
    const float m2y = m1y * m1y;
    const float m2z = m1z * m1z;
    
    const float m4x = m2x * m2x;
    const float m4y = m2y * m2y;
    const float m4z = m2z * m2z;
    
    float intp;
    const float xx = 2.0 * modff(px * CW, &intp) - 1.0;
    const float xy = 2.0 * modff(py * CW, &intp) - 1.0;
    const float xz = 2.0 * modff(pz * CW, &intp) - 1.0;
    
    const float hx = fabsf(xx) - 0.5;
    const float hy = fabsf(xy) - 0.5;
    const float hz = fabsf(xz) - 0.5;
    
    const float oxx = floorf(xx + 0.5);
    const float oxy = floorf(xy + 0.5);
    const float oxz = floorf(xz + 0.5);
    
    const float a0x = xx - oxx;
    const float a0y = xy - oxy;
    const float a0z = xz - oxz;
    
    const float mx = m4x * (1.79284291400159 - 0.85373472095314 * ((a0x * a0x) + (hx * hx)));
    const float my = m4y * (1.79284291400159 - 0.85373472095314 * ((a0y * a0y) + (hy * hy)));
    const float mz = m4z * (1.79284291400159 - 0.85373472095314 * ((a0z * a0z) + (hz * hz)));
    
    const float gx = (a0x * x0u) + (hx * x0v);
    const float gy = (a0y * x12x) + (hy * x12y);
    const float gz = (a0z * x12z) + (hz * x12w);
    
    return 130.0 * ((mx * gx) + (my * gy) + (mz * gz));
}

static float fclampf(float x, float min, float max) {
    if(!(x >= min)) return min;
    if(!(x <= max)) return max;
    
    return x;
}
  
static void homogen_uv(float F, float k, float *u, float *v) {
    const float sqrt_F = sqrtf(F);
    float U = 1.0;
    float V = 1.0;
    
    if(k < ((sqrt_F - (2.0 * F)) / 2.0)) {
        const float A = sqrt_F / (F + k);
        const float B = sqrtf((A * A) - 4.0);
        U = fclampf(          (A - B)  / (2.0 * A), 0.0, 1.0);
        V = fclampf((sqrt_F * (A + B)) /  2.0     , 0.0, 1.0);
    }
    
    *u = U;
    *v = V;
}

void noise(float F, float k, float *p, size_t x, size_t y) {
    float hu, hv;
    homogen_uv(F, k, &hu, &hv);
    
    const float nu = (float) x / WIDTH;
    const float nv = (float) y / HEIGHT;
    
    const float t1 = 0.5 * (snoise(        0.10 * nu ,         0.10 * nv ) + snoise(        0.16 * nu ,         0.16 * nv));
    const float t2 = 0.5 * (snoise(0.30 - (0.13 * nu), 0.30 - (0.13 * nv)) + snoise(0.70 - (0.21 * nu), 0.70 - (0.21 * nv)));
    
    p[0] = fclampf(nu - 0.25 + t1, 0, 1);
    p[1] = fclampf(nv - 0.25 + t2, 0, 1);
}

