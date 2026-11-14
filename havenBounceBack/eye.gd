extends CharacterBody2D


signal done_eye

@export var speed = 420
@export var visual = ["normal","frown","cori"].pick_random() # list of the different eyes

var placing_eye = false
var can_be_paused_now = false

func start():
	print("eye started")
	placing_eye = true
	position = get_viewport_rect().size / 2
	
	var direction_x = randf_range(-0.7,0.7)
	# yay gambling
	
	var direction_y = randf_range(-0.5,0.5)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
	
func _ready():
	velocity = Vector2.ZERO
	$AnimatedSprite2D.play(visual)
	# potential for blinking later
	#$EyeDemo2.material.set_shader_parameter("hihi",0.0)
#
	#start()

func _physics_process(delta):
	if(placing_eye):
		if(Input.is_action_just_pressed("pause") && can_be_paused_now):
			velocity = Vector2.ZERO
			done_eye.emit()
		if(Input.is_action_just_pressed("rotate_clockwise")):
			$AnimatedSprite2D.rotate(PI/6)
		if(Input.is_action_just_pressed("rotate_ccwise")):
			$AnimatedSprite2D.rotate(-PI/6)
			
		var collision = move_and_collide(velocity * delta)
		# move and collide returns a boolean if it hits something
		if collision:
			#$EyeDemo2.rotate(PI / 2)
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D,"scale", Vector2(1.1,1.1), 0.1)
			tween.tween_property($AnimatedSprite2D,"scale", Vector2(1,1), 0.1)
			$AnimatedSprite2D.rotate(PI/2)
			velocity = velocity.bounce(collision.get_normal())

			#print(velocity)
			if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
				velocity *= 1.1
		can_be_paused_now = true
