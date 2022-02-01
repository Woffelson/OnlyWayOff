extends MarginContainer

onready var jason = preload("res://Scenes&scripts/jason.gd")
onready var game = preload("res://Scenes&scripts/MainView.tscn")
onready var teksti = preload("res://Scenes&scripts/Smallstuff/TextItself.tscn")
onready var bt1 = $VBoxContainer/Buttons/VBoxContainer/Button
onready var bt2 = $VBoxContainer/Buttons/VBoxContainer/Button2
onready var bt3 = $VBoxContainer/Buttons/VBoxContainer/Button3
onready var bt4 = $VBoxContainer/Buttons/VBoxContainer/Button4
onready var speis = $VBoxContainer/Speissss

var jansson = null
var buttons = []
var focused = false
var playerfinder = null
var parentti = null
var instructions = ""
var txt = null

func _ready():
	buttons.append(bt1)
	buttons.append(bt2)
	buttons.append(bt3)
	buttons.append(bt4)
	jansson = jason.new()

func _process(_delta):
	for bt in buttons: #goes through buttons and checks if they're focused
		if bt.has_focus():
			focused = true #ok they are
			break
	if !focused: #crappy way to make keys work on menu but it works...
		if Input.is_action_just_pressed("key_down"):
			bt1.grab_focus()
		if Input.is_action_just_pressed("key_up"):
			bt4.grab_focus()
	if Input.is_action_just_pressed("key_start"):
		pause_off()

func instance_create(obj,creator):#xy
	var id = obj.instance()
	creator.add_child(id)
	#id.position = xy#Vector2(x,y)
	return id

func pause_off():
	get_tree().paused = false
	queue_free()
	parentti.klik.play()

func _on_Button_pressed(): #back in the game!
	pause_off()

func _on_Button2_pressed(): #save game
	var possi = [playerfinder.position.x,playerfinder.position.y]
	jansson.save_data(possi,playerfinder.powerups)
	var txt = instance_create(teksti,speis)
	txt.rtext.bbcode_text = "Saved!"
	parentti.klik.play()

func _on_Button3_pressed(): #back to main menu
	parentti.remove_child(parentti.game_view)
	parentti.add_child(parentti.menu_itself)
	parentti.focused = false
	parentti.pic.show()
	pause_off()

func _on_Button4_pressed():
	get_tree().quit()

func _on_Button5_pressed():
	if txt == null:
		txt = instance_create(teksti,speis)
		txt.rtext.bbcode_text = instructions
	else:
		speis.remove_child(txt)
		txt.rtext.bbcode_text = ""
		txt = null
	parentti.klik.play()
