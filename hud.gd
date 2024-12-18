extends CanvasLayer

@export var forme:String="CYLINDER_UPRIGHT"

signal forme_changed(new_value)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("wheel"):
		$SelectionWheel.show()
	if Input.is_action_just_released("wheel"):
		var forme = $SelectionWheel.Close()
		emit_signal("forme_changed",forme)
	
