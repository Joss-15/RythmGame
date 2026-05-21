shader_type canvas_item;

uniform vec3 color_0 = vec3(1.0, 0.3, 0.3); // S
uniform vec3 color_1 = vec3(1.0, 0.6, 0.2); // D
uniform vec3 color_2 = vec3(1.0, 1.0, 0.2); // F
uniform vec3 color_3 = vec3(0.2, 0.8, 1.0); // H
uniform vec3 color_4 = vec3(0.5, 0.5, 1.0); // J
uniform vec3 color_5 = vec3(0.8, 0.3, 1.0); // K

uniform float intensities[6];
uniform float is_miss[6];

void fragment() {
    vec2 uv = UV - 0.5;
    uv.x *= 2.69; 
    
    // Rotación base lentísima
    float angle = atan(uv.y, uv.x) + TIME * 0.15; 
    float r = length(uv);
    
    // Forma de la flor (6 pétalos)
    float warped_r = r * (1.0 - 0.15 * cos(angle * 6.0));
    
    // Tamaños fijos de los 6 anillos
    float radii[6] = float[6](0.08, 0.14, 0.20, 0.26, 0.32, 0.38);
    vec3 colors[6] = vec3[6](color_0, color_1, color_2, color_3, color_4, color_5);
    
    vec3 final_pixel = vec3(0.0);
    float final_alpha = 0.0;
    float thickness = 0.012; 
    
    for (int i = 0; i < 6; i++) {
        // --- EFECTO SPAGHETTI / BAJO EL AGUA ---
        // Generamos dos ondas que se cruzan para un movimiento más natural.
        // float(i) asegura que cada línea (0 al 5) tenga un desfase diferente.
        float wave1 = sin(angle * 8.0 + TIME * 2.5 + float(i) * 1.5) * 0.003;
        float wave2 = cos(angle * 14.0 - TIME * 1.8 + float(i) * 2.2) * 0.002;
        float wobble = wave1 + wave2; 
        
        // Aplicamos la torcedura ('wobble') al radio de esta línea específica
        float dist = abs(warped_r - (radii[i] + wobble));
        
        // Dibujamos la línea
        float line = smoothstep(thickness, thickness * 0.4, dist);
        
        vec3 ring_color = mix(colors[i], vec3(1.0, 0.0, 0.0), is_miss[i]);
        
        final_pixel += ring_color * intensities[i] * line;
        final_alpha += line;
    }
    
    COLOR = vec4(final_pixel, clamp(final_alpha, 0.0, 1.0));
}