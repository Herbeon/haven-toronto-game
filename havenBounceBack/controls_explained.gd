extends TextureRect

var reaction = "happy"
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$incurby.play(reaction)
	if(Input.is_action_pressed("pause")):
		if(Input.is_action_just_pressed("pause")):
			var tween = create_tween()
			tween.tween_property($incurby,"scale", Vector2(1.0,1.02), 0.1)
			tween.tween_property($incurby,"scale", Vector2(1,1), 0.1)
			var gambler = randf()
			if(gambler < 0.2):
				reaction = "sad"
			elif(gambler < 0.5):
				reaction = "happy"
			else:
				reaction = "neutral"
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
