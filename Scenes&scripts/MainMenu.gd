extends MarginContainer

onready var jason = preload("res://Scenes&scripts/jason.gd")
onready var game = preload("res://Scenes&scripts/MainView.tscn")
onready var bt1 = $VBoxContainer/Buttons/VBoxContainer/Button
onready var bt2 = $VBoxContainer/Buttons/VBoxContainer/Button2
onready var bt3 = $VBoxContainer/Buttons/VBoxContainer/Button3
onready var bt4 = $VBoxContainer/Buttons/VBoxContainer/Button4

var menu_itself = null
var jansson = null
var buttons = []
var focused = false

func _ready():
	menu_itself = get_node("VBoxContainer")
	buttons.append(bt1)
	buttons.append(bt2)
	buttons.append(bt3)
	buttons.append(bt4)
	jansson = jason.new()

func _process(delta):
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
	game = instance_create(game,self).find_node("GameMain") #game is buried deep in that scene......

func _on_Button_pressed(): #continue game
	jansson.read_jason() #initializes the save file if doesn't exist or just checking it out idk
	letsagoo()
	jansson.load_data(game.plaa) #does it really work???

func _on_Button2_pressed(): #new game
	jansson.read_jason() #initializes the save file if doesn't exist or just checking it out idk
	jansson.delete_jason() #cleans any previous save files
	letsagoo()

func _on_Button3_pressed():
	pass # Replace with function body.

func _on_Button4_pressed():
	get_tree().quit()
