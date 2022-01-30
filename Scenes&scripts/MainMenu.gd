extends MarginContainer

onready var jason = preload("res://Scenes&scripts/jason.gd")
onready var peli = preload("res://Scenes&scripts/MainView.tscn")
onready var pause = preload("res://Scenes&scripts/PauseMenu.tscn")
onready var teksti = preload("res://Scenes&scripts/Smallstuff/TextItself.tscn")
onready var bt1 = $VBoxContainer/Buttons/VBoxContainer/Button
onready var bt2 = $VBoxContainer/Buttons/VBoxContainer/Button2
onready var bt3 = $VBoxContainer/Buttons/VBoxContainer/Button3
onready var bt4 = $VBoxContainer/Buttons/VBoxContainer/Button4
onready var speis = $VBoxContainer/Speissss
onready var paussitaso = $PauseLayer
onready var klik = $klik

var instructions = "You can move with arrows or WASD, Z and X might do something, esc pauses game etc. Have fun, there's not much sensible to do."
var menu_itself = null
#var pause_menu = null
var game = null
var game_view = null
var jansson = null
var buttons = []
var focused = false
var playerfinder = null
var dteksti = null

func _ready():
	menu_itself = get_node("VBoxContainer")
	buttons.append(bt1)
	buttons.append(bt2)
	buttons.append(bt3)
	buttons.append(bt4)
	jansson = jason.new()

func _process(_delta):
	debug() #comment/deletus/yeetus this when game is ready
	for bt in buttons: #goes through buttons and checks if they're focused
		if bt.has_focus():
			focused = true #ok they are
			break
	if !focused: #crappy way to make keys work on menu but it works...
		if Input.is_action_just_pressed("key_down"):
			bt1.grab_focus()
		if Input.is_action_just_pressed("key_up"):
			bt4.grab_focus()
	if Input.is_action_just_pressed("key_start") && !has_node("VBoxContainer"): #pause
		var pauze = instance_create(pause,paussitaso)
		pauze.playerfinder = playerfinder
		pauze.parentti = self
		pauze.instructions = instructions
		get_tree().paused = true

func debug():
	if Input.is_action_just_pressed("ui_page_up"):
		print(game)
		jansson.save_data([game.plaa.position.x,game.plaa.position.y])
	if Input.is_action_just_pressed("ui_page_down"):
		jansson.load_data(game.plaa)

func instance_create(obj,creator):#xy
	var id = obj.instance()
	creator.add_child(id)
	#id.position = xy#Vector2(x,y)
	return id

func letsagoo(): #takes in the game
	remove_child(menu_itself)
	game_view = instance_create(peli,self)
	game = game_view.find_node("GameMain") #game is buried deep in that scene......
	playerfinder = game.plaa
	#dteksti = game.find_node("Kontti")

func _on_Button_pressed(): #continue game
	jansson.read_jason() #initializes the save file if doesn't exist or just checking it out idk
	letsagoo()
	jansson.load_data(game.plaa) #does it really work???
	klik.play()

func _on_Button2_pressed(): #new game
	jansson.read_jason() #initializes the save file if doesn't exist or just checking it out idk
	jansson.delete_jason() #cleans any previous save files
	letsagoo()
	klik.play()

func _on_Button3_pressed():
	var txt = instance_create(teksti,speis)
	txt.rtext.bbcode_text = instructions
	klik.play()

func _on_Button4_pressed():
	get_tree().quit()
