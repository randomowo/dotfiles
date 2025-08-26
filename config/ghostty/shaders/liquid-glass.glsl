// Noise function for organic glass distortion
float noise(vec2 p) {
    return fract(sin(dot(p, vec2(12.9898, 78.233))) * 43758.5453);
}

// Smooth noise
float smoothNoise(vec2 p) {
    vec2 i = floor(p);
    vec2 f = fract(p);
    f = f * f * (3.0 - 2.0 * f);

    float a = noise(i);
    float b = noise(i + vec2(1.0, 0.0));
    float c = noise(i + vec2(0.0, 1.0));
    float d = noise(i + vec2(1.0, 1.0));

    return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

// Fractal noise for complex glass patterns
float fbm(vec2 p) {
    float value = 0.0;
    float amplitude = 0.5;
    float frequency = 1.0;

    for (int i = 0; i < 5; i++) {
        value += amplitude * smoothNoise(p * frequency);
        amplitude *= 0.5;
        frequency *= 2.0;
    }

    return value;
}

// Apple-style gradient colors with time-based shifting
vec3 gradientColor(vec2 uv, float time) {
    // Base colors that will shift over time
    vec3 top = vec3(0.85, 0.95, 1.00);    // pale mint/blue
    vec3 middle = vec3(0.96, 0.96, 0.98); // pearly white
    vec3 bottom = vec3(0.90, 0.80, 0.92); // soft lavender/pink

    // Create time-based color variations
    float timeShift = sin(time * 0.5) * 0.1;
    float timeShift2 = cos(time * 0.3) * 0.08;
    float timeShift3 = sin(time * 0.7) * 0.06;

    // Shift hues over time
    top += vec3(timeShift, timeShift2 * 0.5, timeShift3);
    middle += vec3(timeShift2 * 0.3, timeShift, timeShift2);
    bottom += vec3(timeShift3, timeShift * 0.7, timeShift);

    // Ensure colors stay within valid range
    top = clamp(top, 0.0, 1.0);
    middle = clamp(middle, 0.0, 1.0);
    bottom = clamp(bottom, 0.0, 1.0);

    // Use smoothstep for much smoother transitions
    float t = uv.y;

    // Create smooth gradient zones with overlap
    float bottomWeight = 1.0 - smoothstep(0.0, 0.6, t);
    float middleWeight = 1.0 - abs(t - 0.5) * 2.0;
    middleWeight = smoothstep(0.0, 1.0, middleWeight);
    float topWeight = smoothstep(0.4, 1.0, t);

    // Normalize weights
    float totalWeight = bottomWeight + middleWeight + topWeight;
    bottomWeight /= totalWeight;
    middleWeight /= totalWeight;
    topWeight /= totalWeight;

    // Blend all colors smoothly
    vec3 col = bottom * bottomWeight + middle * middleWeight + top * topWeight;

    return col;
}

// Glass refraction effect
vec2 glassDistortion(vec2 uv, float time) {
    // Create more pronounced glass distortion with smoother waves
    float wave1 = sin(uv.y * 4.0 + time * 0.8) * 0.015;
    float wave2 = cos(uv.x * 3.0 + time * 0.6) * 0.012;

    // Add multiple layers of smooth fbm noise for organic glass feel
    float noise1 = fbm(uv * 1.5 + time * 0.05) * 0.008;
    float noise2 = fbm(uv * 2.5 - time * 0.04) * 0.006;
    float noise3 = fbm(uv * 4.0 + time * 0.03) * 0.004;

    return vec2(wave1 + noise1 + noise3, wave2 + noise2 + noise3);
}

void mainImage(out vec4 fragColor, in vec2 fragCoord) {
    vec2 uv = fragCoord / iResolution.xy;
    vec2 centeredUV = (fragCoord - 0.5 * iResolution.xy) / min(iResolution.x, iResolution.y);

    // Sample the original texture without distortion
    vec4 originalColor = texture(iChannel0, uv);

    // Apply glass distortion only for gradient color
    vec2 distortion = glassDistortion(uv, iTime);
    vec2 glassUV = uv + distortion;

    // Handle transparency for glass effect
    if (originalColor.a == 0.0) {
        originalColor.a = 0.4;
    }

    // Get the gradient color with distortion
    vec3 gradient = gradientColor(glassUV, iTime);

    // Create stronger glass highlight effects
    float highlight1 = smoothstep(0.5, 1.0, fbm(centeredUV * 3.0 + iTime * 0.1));
    float highlight2 = smoothstep(0.4, 0.9, fbm(centeredUV * 5.0 - iTime * 0.12));

    // Glass reflection effect
    float reflection = pow(abs(sin(centeredUV.x * 2.0 + iTime * 0.3)), 3.0) * 0.3;
    reflection += pow(abs(cos(centeredUV.y * 1.5 + iTime * 0.4)), 2.0) * 0.2;

    // Combine highlights
    float totalHighlight = (highlight1 * 0.2 + highlight2 * 0.15 + reflection) * 0.4;

    // Apply gradient to original color
    vec3 colorWithGradient = originalColor.rgb * gradient;

    // Add glass highlights
    vec3 glassHighlight = vec3(0.6, 0.7, 0.8) * totalHighlight;
    vec3 finalColor = colorWithGradient + glassHighlight;

    // Add subtle glass tint variation based on position
    float tintVariation = sin(uv.x * 3.0 + iTime * 0.2) * 0.03;
    finalColor += vec3(0.01, 0.03, 0.05) * tintVariation;

    // Apply slight saturation boost for glass effect
    float saturation = 1.1;
    vec3 gray = vec3(dot(finalColor, vec3(0.299, 0.587, 0.114)));
    finalColor = mix(gray, finalColor, saturation);

    fragColor = vec4(finalColor, originalColor.a);
}