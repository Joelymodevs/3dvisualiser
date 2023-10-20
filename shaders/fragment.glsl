varying vec2 vUv;
varying float vPattern;
uniform float uTime;
uniform float uAudioFrequency;

struct Color {
    vec3 color;
    float position;
};

#define COLOR_RAMP(colors, factor, finalColor) { \
    const int len = 4; \
    int index = 0; \
    for(int i = 0; i < len - 1; i++){ \
       Color currentColor = colors[i]; \
       bool isInBetween = currentColor.position <= factor; \
       index = int(mix(float(index), float(i), float(isInBetween))); \
    } \
    Color currentColor = colors[index]; \
    Color nextColor = colors[index + 1]; \
    float range = nextColor.position - currentColor.position; \
    float lerpFactor = (factor - currentColor.position) / range; \
    finalColor = mix(currentColor.color, nextColor.color, lerpFactor); \
}

void main() {
    float time = uTime * (1.0 + uAudioFrequency);

    vec3 color;
    
    vec3 mainColor = mix(vec3(0.2, 0.3, 1.6), vec3(0.4, 2.0, 0.3), uAudioFrequency);

    mainColor.r *= 0.9 + sin(time) / 3.2;
    mainColor.g *= 1.1 + cos(time / 2.0) / 2.5;
    mainColor.b *= 0.8 + cos(time / 5.0) / 4.0;

    mainColor.rgb += 0.1;


    Color[4] colors = Color[](
        Color(vec3(1), 0.0),
        Color(vec3(1), 0.01),
        Color(mainColor, 0.1),
        Color(vec3(0.01, 0.1, 0.2), 1.0)
    );

    COLOR_RAMP(colors, vPattern, color);

    gl_FragColor = vec4(color, 1.0);
}
