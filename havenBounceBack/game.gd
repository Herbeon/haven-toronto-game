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

@onready var decor1 = $decor1
@onready var decor2 = $decor2

@onready var label = $Control/Label
@onready var relabel = $Control/Relabel

var reloads_left = 50
var complete_pic = false
@onready var current_part = $torso

@onready var bg_music = $AudioStreamPlayer

var game_started_lol = false
# can spawn at each but htat's too much work
#@onready var boing1 = $Audioboing1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Audioyippie.play()
	$complete.visible = false
	bg_music.autoplay = false
	#load("res://audio/ambientwaterfall.wav")
	$title_screen.game_started.connect(title_screen_clicked)
	eye1.done_eye.connect(eye1_is_done)
	
	eye1.collided.connect(collisionhappened)
	eyebrow1.collided.connect(collisionhappened)
	eyebrow2.collided.connect(collisionhappened)

	eye2.collided.connect(collisionhappened)
	ear1.collided.connect(collisionhappened)
	ear2.collided.connect(collisionhappened)
	hairback.collided.connect(collisionhappened)
	hairfront.collided.connect(collisionhappened)
	mouth.collided.connect(collisionhappened)
	hat.collided.connect(collisionhappened)
	head.collided.connect(collisionhappened)
	headacc1.collided.connect(collisionhappened)
	headacc2.collided.connect(collisionhappened)
	decor1.collided.connect(collisionhappened)
	decor2.collided.connect(collisionhappened)

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
	
	decor1.done_decor1.connect(decor1_is_done)
	decor2.done_decor2.connect(decor2_is_done)
	
	hat.done_hat.connect(hat_is_done)
	#new_game()

func _process(float) -> void:
	if(!bg_music.playing && game_started_lol):
		bg_music.play()
	if(Input.is_action_just_pressed("reload")):
		$Audioboop.play()
		if(reloads_left > 0 && !complete_pic):
			current_part.start()
			
			reloads_left -= 1
			relabel.text = "reloads left: " + str(reloads_left)
		else:
			relabel.text = "no more reloads left!"
	if(Input.is_action_just_pressed("trashbin")):
		$Audioblorp.play()
		current_part.visible = false
		current_part.got_paused()
	#if(Input.is_action_just_pressed("newgame")):
		#new_game()

func collisionhappened():
	var toplay = [$Audioboing1,$Audioboing2,$Audioboing3].pick_random()
	while(toplay.playing):
		toplay = [$Audioboing1,$Audioboing2,$Audioboing3].pick_random()
	toplay.play()
	
func title_screen_clicked():
	game_started_lol = true

	new_game()

func new_game():
	bg_music.play()
	# a new game. do stuff
	# skip to eye part
	#print("new game!")
	torso.start()
	head.start()
	current_part = $head
	label.text = "Currently placing head"
	relabel.text = "reloads left: " + str(reloads_left)
	
func head_is_done():
	$Audiobeep.play()

	label.text = "Currently placing first eye"
	current_part = $eye1

	eye1.start()
	#print("start 1 eye")


func eye1_is_done():
	$Audiobeep.play()

	label.text = "Currently placing second eye"
	current_part = $eye2
	eye2.start()

func eye2_is_done():
	$Audiobeep.play()

	label.text = "Currently placing first eyebrow"
	current_part = $eyebrow1

	eyebrow1.start()
	
func eyebrow1_is_done():
	$Audiobeep.play()

	label.text = "Currently placing second eyebrow"
	current_part = $eyebrow2
	
	eyebrow2.start()

func eyebrow2_is_done():
	$Audiobeep.play()

	label.text = "Currently placing first ear"
	current_part = $ear1
	
	ear1.start()


func ear_is_done():
	$Audiobeep.play()

	label.text = "Currently placing second ear"

	current_part = $ear2

	ear2.start()
	
func ear_2_is_done():
	$Audiobeep.play()

	label.text = "Currently placing mouth"

	current_part = $mouth
	mouth.start()
	
func mouth_is_done():
	$Audiobeep.play()

	label.text = "Currently placing back of hair"
	
	current_part = $hairback
	hairback.start()
	
func hairback_is_done():
	$Audiobeep.play()

	label.text = "Currently placing front of hair"
	
	current_part = $hairfront
	hairfront.start()
	
func hairfront_is_done():
	$Audiobeep.play()

	label.text = "Currently placing neck accessory"
	
	current_part = $clothesacc
	clothesacc.start()

func clothesacc_is_done():
	$Audiobeep.play()

	label.text = "Currently placing head accessory 1"
	current_part = $headacc1
	headacc1.start()

func headacc1_is_done():
	$Audiobeep.play()

	label.text = "Currently placing head accessory 2"
	current_part = $headacc2
	headacc2.start()

func headacc2_is_done():
	$Audiobeep.play()

	label.text = "Currently placing hat"
	current_part = $hat
	
	hat.start()
	
func hat_is_done():
	$Audiobeep.play()

	label.text = "Currently placing decor 1"
	current_part = $decor1
	
	decor1.start()

func decor1_is_done():
	$Audiobeep.play()

	label.text = "Currently placing decor 2"
	current_part = $decor2 
	decor2.start()
	
func decor2_is_done():
	$Audiotada.play()
	$complete.visible = true
	var tween = create_tween()
	tween.tween_property($complete,"scale", Vector2(1,1.1), 0.1)
	tween.tween_property($complete,"scale", Vector2(1,1), 0.1)
	label.text = ""
	relabel.text = ""
	
