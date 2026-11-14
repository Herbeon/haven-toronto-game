extends Node2D
#
#the layers are (bottom to top)
#* background
#* torso
#* clothes?
#* head
#* hair
#* head accessory
#* hat
#* face: eyes, mouth
#* decoration?

@onready var torso = $torso

@onready var head = $head
@onready var eye1 = $eye1
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
	label.text = "Currently placing eye"
	current_part = $eye1

	eye1.start()
	#print("start 1 eye")

func eye_is_done():
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
	
