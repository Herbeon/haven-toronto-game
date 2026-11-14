extends CharacterBody2D

signal out_of_bounds

@export var speed = 300
@export var visual = "normal"

var paused = false

func start():
	position = get_viewport_rect().size / 2
	
	var direction_x = randf_range(-1,1)
	# yay gambling
	
	var direction_y = randf_range(-1,1)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
	
func _ready():
	#$AnimatedSprite2D.play(visual)
	# potential for blinking later
	#$EyeDemo2.material.set_shader_parameter("hihi",0.0)

	start()

func _physics_process(delta):
	if(Input.is_action_just_pressed("pause")):
		velocity = Vector2.ZERO
		paused = true
		#$EyeDemo2.material.set_shader_parameter("hihi",1.0)
	if position.x < 0 or position.x > get_viewport_rect().size.x:
		# left/right
		out_of_bounds.emit() # signalname.emit() sends a signal
		start()
	
	if position.y < 0 or position.y > get_viewport_rect().size.y:
		start() 

	var collision = move_and_collide(velocity * delta)
	# move and collide returns a boolean if it hits something
	if collision:
		$EyeDemo2.rotate(PI / 2)
		#$AnimatedSprite2D.rotate(PI/2)
		velocity = velocity.bounce(collision.get_normal())

		var thing_we_hit = collision.get_collider()
		print(velocity)
		if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
			velocity *= 1.1
