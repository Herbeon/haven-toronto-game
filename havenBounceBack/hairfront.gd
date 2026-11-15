extends CharacterBody2D


signal done_hairfront

@export var speed = 300
@export var visual = "" 

var placing_hf = false
var can_be_paused_now = false


func start():
	visual = ["bowl1","bowl2","bowl3","incurable1","incurable2","incurable3","traveller1","traveller2","traveller3"].pick_random()
	$AnimatedSprite2D.play(visual)

	placing_hf = true
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
	if(placing_hf):
		if(Input.is_action_just_pressed("pause") && can_be_paused_now):
			got_paused()
		if(Input.is_action_just_pressed("rotate_clockwise")&& placing_hf):
			$AnimatedSprite2D.rotate(PI/12)
		if(Input.is_action_just_pressed("rotate_ccwise")&& placing_hf):
			$AnimatedSprite2D.rotate(-PI/12)
			
		var collision = move_and_collide(velocity * delta)
		# move and collide returns a boolean if it hits something
		if collision:
			velocity = velocity.bounce(collision.get_normal())

			#print(velocity)
			if(abs(velocity.x) < 2000 && abs(velocity.y) < 2000):
				velocity *= 1.1
		can_be_paused_now = true

func got_paused():
	velocity = Vector2.ZERO
	done_hairfront.emit()
	can_be_paused_now = false
	placing_hf = false
