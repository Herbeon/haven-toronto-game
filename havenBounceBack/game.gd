extends Node2D
#

#insertion order:
#body (preset)
#head
#ears
#nose 
#mouth
#eyes
#brows
#bangs
#hair
#clothes accessory
#accessory
#hat

@onready var torso = $torso

@onready var head = $head
@onready var eye1 = $eye1
@onready var eye2 = $eye2

@onready var ear1 = $ear1
@onready var ear2 = $ear2
@onready var mouth = $mouth

@onready var label = $Control/Label
@onready var relabel = $Control/Relabel

var reloads_left = 50

@onready var current_part = $torso

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eye1.done_eye.connect(eye_is_done)
	eye2.done_eye2.connect(eye2_is_done)

	head.done_head.connect(head_is_done)
	ear1.done_ear.connect(ear_is_done)
	ear2.done_ear.connect(ear_2_is_done)
	new_game()

func _process(float) -> void:
	if(Input.is_action_just_pressed("reload")):
		if(reloads_left > 0):
			current_part.start()
			
			reloads_left -= 1
			relabel.text = "reloads left: " + str(reloads_left)
		else:
			relabel.text = "no more reloads left lol"


func new_game():
	# a new game. do stuff
	# skip to eye part
	torso.start()
	head.start()
	current_part = $head
	label.text = "Currently placing head"
	relabel.text = "reloads left: " + str(reloads_left)
	
func head_is_done():
	label.text = "Currently placing first eye"
	current_part = $eye1

	eye1.start()
	#print("start 1 eye")

func eye_is_done():
	label.text = "Currently placing second eye"
	current_part = $eye2
	eye2.start()

func eye2_is_done():
	label.text = "Currently placing first ear"
	current_part = $ear1

	ear1.start()


func ear_is_done():
	label.text = "Currently placing second ear"

	current_part = $ear2

	ear2.start()
	
func ear_2_is_done():
	label.text = "Currently placing mouth"

	current_part = $mouth
	mouth.start()
	
