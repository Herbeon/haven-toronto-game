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

@onready var label = $Control/Label

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	eye1.done_eye.connect(eye_is_done)
	head.done_head.connect(head_is_done)
	ear1.done_ear.connect(ear_is_done)
	new_game()


func new_game():
	# a new game. do stuff
	# skip to eye part
	torso.start()
	head.start()
	label.text = "Currently placing head"
	
func head_is_done():
	label.text = "Currently placing eye"
	eye1.start()
	#print("start 1 eye")

func eye_is_done():
	label.text = "Currently placing ear"
	ear1.start()


func ear_is_done():
	#print("helo ear done")
	pass
