shader_type canvas_item;

uniform float persent : hint_range(0, 1);

void fragment() {
	vec4 text = texture(TEXTURE, UV);
	
	if (persent > UV.x) {
		COLOR = text;
	} else {
		COLOR = vec4(0);
	}
}
