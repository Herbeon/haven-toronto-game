extends CharacterBody2D


signal done_ear
signal collided

@export var speed = 420
@export var visual = "" # list of the different ears

var placing_ear = false
var can_be_paused_now = false


func start():
	visual = ["hungri","human","fox"].pick_random()
	$AnimatedSprite2D.play(visual)

	get_node("CollisionShape2D").disabled = true
	get_node("CollisionShape2Dbig").disabled = true
	get_node("CollisionShape2Dsmol").disabled = true

	if(visual == "hungri"):
		get_node("CollisionShape2Dbig").disabled = false
	if(visual == "human"):
		#print("human")
		get_node("CollisionShape2Dsmol").disabled = false
	if(visual == "fox"):
		#print("fox")
		get_node("CollisionShape2D").disabled = false



	placing_ear = true
	position = Vector2(520,500)
	
	var direction_x = randf_range(-1,1)
	# yay gambling
	
	var direction_y = randf_range(0,1)
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
	if(placing_ear):
		if(Input.is_action_just_pressed("pause") && can_be_paused_now):
			got_paused()
		if(Input.is_action_just_pressed("rotate_clockwise")&& placing_ear):
			$AnimatedSprite2D.rotate(PI/6)
		if(Input.is_action_just_pressed("rotate_ccwise")&& placing_ear):
			$AnimatedSprite2D.rotate(-PI/6)
			
		var collision = move_and_collide(velocity * delta)
		# move and collide returns a boolean if it hits something
		if collision:
			collided.emit()
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D,"scale", Vector2(1.1,1.1), 0.1)
			tween.tween_property($AnimatedSprite2D,"scale", Vector2(1,1), 0.1)
			if(visual != "hungri"):
				var rotationamount = tan(velocity.x / velocity.y)
				$AnimatedSprite2D.rotate(rotationamount*2)

				#$CollisionShape2Dbig.rotate(PI/2)
			velocity = velocity.bounce(collision.get_normal())

			#print(velocity)
			if(abs(velocity.x) < 1500 && abs(velocity.y) < 1500):
				velocity *= 1.1
		can_be_paused_now = true

func got_paused():
	velocity = Vector2.ZERO
	done_ear.emit()
	can_be_paused_now = false
	placing_ear = false
