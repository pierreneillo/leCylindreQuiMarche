@tool
extends Control

const sizeOfImages:int=128
const SPRITE_SIZE = Vector2(sizeOfImages,sizeOfImages)

@export var bkg_color : Color
@export var line_color: Color
@export var highlight_color: Color

@export var outer_radius: int = 256
@export var inner_radius:int = 50
@export var line_widht:int = 4

@export var options: Array[WheelOption]
var angles = []
var selection=0

func Close():
	hide()
	return options[selection].name

func _ready():
	hide()

# Called when the node enters the scene tree for the first time.
func _draw() -> void:
	var offset = SPRITE_SIZE/-2
	
	draw_circle(Vector2.ZERO, outer_radius, bkg_color)
	draw_arc(Vector2.ZERO,inner_radius,0,TAU,120,line_color,line_widht,true)
	var debFin = []
	if len(options)>=1:
		for i in range(len(options)):
			var rads = TAU*i/(len(options))
			if len(debFin)<=1:
				debFin.append(rads)
			if len(debFin)==2:
				if debFin not in angles:
					angles.append(debFin)
				debFin=[rads]
			var point = Vector2.from_angle(rads)
			draw_line(point*inner_radius,point*outer_radius,line_color,line_widht,true)
	if len(debFin)!=0:
		debFin.append(TAU)
		if debFin not in angles:
			angles.append(debFin)
		debFin=[]
	for i in range(len(options)):
		var start_rads=-1* angles[i][0]
		var end_rads =-1* angles[i][1]

		var mid_rads = (start_rads+end_rads)/2 * -1
		var radius_mid = (inner_radius+outer_radius)/2
		
		if selection == i: 
			var points_per_arc = 32 
			var points_inner = PackedVector2Array()
			var points_outer = PackedVector2Array()
			for j in range(points_per_arc+1):
				var ang= start_rads + j*(end_rads-start_rads)/points_per_arc 
				points_inner.append(inner_radius*Vector2.from_angle(ang))
				points_outer.append(outer_radius*Vector2.from_angle(ang))
			points_outer.reverse()
			draw_polygon(points_inner + points_outer,PackedColorArray([highlight_color]))
		
		# Position centrale pour la boîte
		var box_pos = radius_mid * Vector2.from_angle(mid_rads) *-1 + offset
		var box_size = SPRITE_SIZE

		# Récupère la texture et sa taille
		var texture = options[i].atlas
		var texture_size = texture.get_size()
		# Calcule le facteur d'échelle pour ajuster l'image dans la boîte
		var scale_factor = min(box_size.x / texture_size.x, box_size.y / texture_size.y)
		# Nouvelle taille après redimensionnement
		var scaled_size = texture_size * scale_factor
		# Position pour centrer l'image redimensionnée dans la boîte
		var scaled_pos = box_pos + (box_size - scaled_size) / 2
		
		# Dessine l'image redimensionnée et centrée
		draw_texture_rect(texture, Rect2(scaled_pos, scaled_size),false)
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var mouse_pos=get_local_mouse_position()
	var mouse_radius= mouse_pos.length()
	if mouse_radius>inner_radius:
		var mouse_rads = fposmod(mouse_pos.angle()*-1, TAU)
		for i in range(len(angles)):
			if angles[i][0] <= angles[i][1]:  # Cas normal
				if mouse_rads >= angles[i][0] and mouse_rads <= angles[i][1]:
					selection = i
					break
			else:  # Cas où l'arc traverse 0
				if mouse_rads >= angles[i][0] or mouse_rads <= angles[i][1]:
					selection = i
					break
	queue_redraw()
