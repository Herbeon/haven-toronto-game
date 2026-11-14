extends Area2D

@export var visual = ["default","cori"].pick_random() # list of the different torsos

# Called when the node enters the scene tree for the first time.

func start():
	$AnimatedSprite2D.play(visual)
	
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
