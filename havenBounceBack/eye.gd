extends CharacterBody2D


signal done_eye

@export var speed = 400
@export var visual = ["normal","frowneye"].pick_random() # list of the different eyes

var placing_eye = false
var can_be_paused_now = false

func start():
	print("eye started")
	placing_eye = true
	position = get_viewport_rect().size / 2
	
	var direction_x = randf_range(-1,1)
	# yay gambling
	
	var direction_y = randf_range(-1,1)
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
		var collision = move_and_collide(velocity * delta)
		# move and collide returns a boolean if it hits something
		if collision:
			#$EyeDemo2.rotate(PI / 2)
			$AnimatedSprite2D.rotate(PI/2)
			velocity = velocity.bounce(collision.get_normal())

			var thing_we_hit = collision.get_collider()
			print(velocity)
			if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
				velocity *= 1.1
		can_be_paused_now = true
