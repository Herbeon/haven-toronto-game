extends CharacterBody2D


signal done_head

@export var speed = 300
@export var visual = "default"

var paused = false

func start():
	position = Vector2(600,600)
	
	var direction_x = randf_range(-1,1)
	# yay gambling
	
	var direction_y = randf_range(-1,1)
	# yay more gambling
	
	velocity = Vector2(direction_x,direction_y).normalized() * speed
	# normalized makes the vector an integer (pythagorean theorem it)
	
func _ready():
	velocity = Vector2.ZERO

func _physics_process(delta):
	if(Input.is_action_just_pressed("pause") && !paused):
		velocity = Vector2.ZERO
		paused = true
		done_head.emit()

	var collision = move_and_collide(velocity * delta)
	# move and collide returns a boolean if it hits something
	if collision:
		$AnimatedSprite2D.rotate(PI / 2)
		velocity = velocity.bounce(collision.get_normal())

		var thing_we_hit = collision.get_collider()
		print(velocity)
		if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
			velocity *= 1.1
