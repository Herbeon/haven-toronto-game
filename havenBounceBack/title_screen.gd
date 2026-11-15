extends Sprite2D

signal game_started

var game_got_started = false

var whee = false
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if(game_got_started):
		pass
	if(whee):
		position.y -= 80
		if(position.y < 0):
			whee = false
			visible = false
			game_got_started = true
			game_started.emit()
	if(Input.is_action_just_pressed("start") && !game_got_started):
		whee = true
		position.y -= 80
