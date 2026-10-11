shader_type spatial;
render_mode cull_disabled;

void fragment() {
    vec2 grid = fract(UV * vec2(60.0, 10.0));

    if (grid.x > 0.08 && grid.x < 0.92 &&
        grid.y > 0.08 && grid.y < 0.92) {
        discard;
    }

    ALBEDO = vec3(0.08, 0.08, 0.08);
    ROUGHNESS = 1.0;
}