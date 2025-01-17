shader_type spatial;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec3 world_normal = (INV_VIEW_MATRIX * vec4(NORMAL.xyz, 0.)).xyz;
	float f = max(0, dot(world_normal, vec3(0, 0, 1)));
	ALBEDO = vec3(0, f, 0);
}

//void light() {
	// Called for every pixel for every light affecting the material.
	// Uncomment to replace the default light processing function with this one.
//}
