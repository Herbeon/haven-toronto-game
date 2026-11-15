extends TextureRect


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(Input.is_action_pressed("pause")):
		$space.visible = true
	else:
		$space.visible = false
	if(Input.is_action_pressed("reload")):
		$enter.visible = true 
	else:
		$enter.visible = false
	if(Input.is_action_pressed("rotate_clockwise")):
		$right.visible = true 
	else:
		$right.visible = false
	if(Input.is_action_pressed("rotate_ccwise")):
		$left.visible = true 
	else:
		$left.visible = false
	if(Input.is_action_pressed("trashbin")):
		$down.visible = true 
	else:
		$down.visible = false
