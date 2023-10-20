varying vec2 vUv;
varying float vPattern;
uniform float uTime;


void main() {
    gl_FragColor = vec4(vec3(vPattern ), 1);
}


