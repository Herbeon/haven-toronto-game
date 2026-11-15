extends CharacterBody2D


signal done_hat

@export var speed = 420
@export var visual = "" 

var placing_hat = false
var can_be_paused_now = false


func start():
	visual = ["party","top","propeller"].pick_random()
	$AnimatedSprite2D.play(visual)

	get_node("CollisionShape2Dbig").disabled = true

	if(visual.contains("propeller")):
		get_node("CollisionShape2Dbig").disabled = false



	placing_hat = true
	position = Vector2(520,520)
	
	var direction_x = randf_range(-0.5,0.5)
	# yay gambling
	
	var direction_y = randf_range(-0.5,0.5)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
	
func _ready():
	velocity = Vector2.ZERO

	#start()

func _physics_process(delta):
	if(placing_hat):
		if(Input.is_action_just_pressed("pause") && can_be_paused_now):
			got_paused()

		if(Input.is_action_just_pressed("rotate_clockwise")&& placing_hat):
			$AnimatedSprite2D.rotate(PI/12)
		if(Input.is_action_just_pressed("rotate_ccwise")&& placing_hat):
			$AnimatedSprite2D.rotate(-PI/12)
			
		var collision = move_and_collide(velocity * delta)
		# move and collide returns a boolean if it hits something
		if collision:
			#var tween = create_tweesn()
			#tween.tween_property($AnimatedSprite2D,"scale", Vector2(1.1,1.1), 0.1)
			#tween.tween_property($AnimatedSprite2D,"scale", Vector2(1,1), 0.1)
			if(!visual.contains("propeller")):
				$AnimatedSprite2D.rotate(PI/2)

			velocity = velocity.bounce(collision.get_normal())

			#print(velocity)
			if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
				velocity *= 1.1
		can_be_paused_now = true

func got_paused():
	velocity = Vector2.ZERO
	done_hat.emit()
	can_be_paused_now = false
	placing_hat = false
