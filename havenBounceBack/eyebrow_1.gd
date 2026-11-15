extends CharacterBody2D


signal done_eb1

@export var speed = 500
@export var visual = ""

var placing_eb1 = false
var can_be_paused_now = false

func start():
	visual = ["normal","thick","concerned"].pick_random()
	$AnimatedSprite2D.play(visual)
	position = Vector2(520,100)

	placing_eb1 = true
	
	var direction_x = randf_range(-0.7,0.7)
	# yay gambling
	
	var direction_y = randf_range(-0.5,0.5)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
	
func _ready():
	velocity = Vector2.ZERO
	# potential for blinking later
	#$EyeDemo2.material.set_shader_parameter("hihi",0.0)
#
	#start()

func _physics_process(delta):
	if(placing_eb1):
		if(Input.is_action_just_pressed("pause") && can_be_paused_now):
			got_paused()
		if(Input.is_action_just_pressed("rotate_clockwise") && placing_eb1):
			#print ("rotate clockwise")
			$AnimatedSprite2D.rotate(PI/6)
		if(Input.is_action_just_pressed("rotate_ccwise") && placing_eb1):
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
			if(abs(velocity.x) < 1500 && abs(velocity.y) < 1500):
				velocity *= 1.1
		can_be_paused_now = true
		
func got_paused():
	velocity = Vector2.ZERO
	done_eb1.emit()
	can_be_paused_now = false
	placing_eb1 = false
