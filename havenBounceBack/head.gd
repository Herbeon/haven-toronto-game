extends CharacterBody2D


signal done_head

@export var speed = 300
@export var visual = "default"

var paused = false

func start():
	position = Vector2(530,350)
	
	var direction_x = 0
	# yay gambling
	
	var direction_y = 1
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
	
func _ready():
	velocity = Vector2.ZERO

func _physics_process(delta):
	if(Input.is_action_just_pressed("pause") && !paused):
		got_paused()

	if(Input.is_action_just_pressed("rotate_clockwise") && !paused):
		position.x += 10
	if(Input.is_action_just_pressed("rotate_ccwise") && !paused):
		position.x -= 10
		
	if(!paused):
		var collision = move_and_collide(velocity * delta)
		# move and collide returns a boolean if it hits something
		if collision:
			var tween = create_tween()
			tween.tween_property($AnimatedSprite2D,"scale", Vector2(1.1,1.1), 0.1)
			tween.tween_property($AnimatedSprite2D,"scale", Vector2(1,1), 0.1)
			if(randf() < 0.5):
				$AnimatedSprite2D.rotate(PI / 20)
			else:
				$AnimatedSprite2D.rotate(-PI / 20)
			velocity = velocity.bounce(collision.get_normal())

			var thing_we_hit = collision.get_collider()
			#print(velocity)
			if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
				velocity *= 1.1
func got_paused():
	velocity = Vector2.ZERO
	paused = true
	done_head.emit()
