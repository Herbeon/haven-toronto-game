extends Node2D
#

#insertion order:
#body (preset)
#head
#ears
#mouth
#eyes
#brows
#hairback

#bangs
#clothes accessory
#accessories on head
#hat

@onready var torso = $torso

@onready var head = $head
@onready var eye1 = $eye1
@onready var eye2 = $eye2
@onready var hairback = $hairback
@onready var hairfront = $hairfront
@onready var ear1 = $ear1
@onready var ear2 = $ear2

@onready var eyebrow1 = $eyebrow1
@onready var eyebrow2 = $eyebrow2

@onready var mouth = $mouth

@onready var clothesacc = $clothesacc
@onready var headacc1 = $headacc1
@onready var headacc2 = $headacc2

@onready var hat = $hat

@onready var label = $Control/Label
@onready var relabel = $Control/Relabel

var reloads_left = 50
var complete_pic = false
@onready var current_part = $torso

@onready var bg_music = $AudioStreamPlayer
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	bg_music.autoplay = true
	#load("res://audio/ambientwaterfall.wav")

	$title_screen.game_started.connect(title_screen_clicked)
	eye1.done_eye.connect(eye1_is_done)
	eye2.done_eye2.connect(eye2_is_done)
	hairback.done_hairback.connect(hairback_is_done)
	hairfront.done_hairfront.connect(hairfront_is_done)

	head.done_head.connect(head_is_done)
	ear1.done_ear.connect(ear_is_done)
	ear2.done_ear.connect(ear_2_is_done)
	mouth.done_mouth.connect(mouth_is_done)
	
	clothesacc.done_clothesacc.connect(clothesacc_is_done)
	headacc1.done_headacc.connect(headacc1_is_done)
	headacc2.done_headacc.connect(headacc2_is_done)

	eyebrow1.done_eb1.connect(eyebrow1_is_done)
	eyebrow2.done_eb2.connect(eyebrow2_is_done)
	
	hat.done_hat.connect(hat_is_done)
	#new_game()

func _process(float) -> void:
	if(!bg_music.playing):
		bg_music.play()
	if(Input.is_action_just_pressed("reload")):
		if(reloads_left > 0 && !complete_pic):
			current_part.start()
			
			reloads_left -= 1
			relabel.text = "reloads left: " + str(reloads_left)
		else:
			relabel.text = "no more reloads left!"
	if(Input.is_action_just_pressed("trashbin")):
		current_part.visible = false
		current_part.got_paused()
	#if(Input.is_action_just_pressed("newgame")):
		#new_game()
		
func title_screen_clicked():
	new_game()

func new_game():
	# a new game. do stuff
	# skip to eye part
	#print("new game!")
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


func eye1_is_done():
	label.text = "Currently placing second eye"
	current_part = $eye2
	eye2.start()

func eye2_is_done():
	label.text = "Currently placing first eyebrow"
	current_part = $eyebrow1

	eyebrow1.start()
	
func eyebrow1_is_done():
	label.text = "Currently placing second eyebrow"
	current_part = $eyebrow2
	
	eyebrow2.start()

func eyebrow2_is_done():
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
	
func mouth_is_done():
	label.text = "Currently placing back of hair"
	
	current_part = $hairback
	hairback.start()
	
func hairback_is_done():
	label.text = "Currently placing front of hair"
	
	current_part = $hairfront
	hairfront.start()
	
func hairfront_is_done():
	label.text = "Currently placing clothing"
	
	current_part = $clothesacc
	clothesacc.start()

func clothesacc_is_done():
	label.text = "Currently placing head accessory 1"
	current_part = $headacc1
	headacc1.start()

func headacc1_is_done():
	label.text = "Currently placing head accessory 2"
	current_part = $headacc2
	headacc2.start()

func headacc2_is_done():
	label.text = "Currently placing hat"
	current_part = $hat
	
	hat.start()
	
func hat_is_done():
	label.text = "Currently should be placing stuff"
	
	
