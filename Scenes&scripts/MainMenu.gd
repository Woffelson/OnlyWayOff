extends MarginContainer

onready var jason = preload("res://Scenes&scripts/jason.gd")
onready var bt1 = $VBoxContainer/Buttons/VBoxContainer/Button
onready var bt2 = $VBoxContainer/Buttons/VBoxContainer/Button2
onready var bt3 = $VBoxContainer/Buttons/VBoxContainer/Button3
onready var bt4 = $VBoxContainer/Buttons/VBoxContainer/Button4

var jansson = null
var buttons = []

func _ready():
	buttons.append(bt1)
	buttons.append(bt2)
	buttons.append(bt3)
	buttons.append(bt4)
	jansson = jason.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	for bt in buttons:
		if !bt.has_focus():
			if Input.is_action_just_pressed("key_down"):
				bt1.grab_focus()
#	pass


func _on_Button_pressed():
	jansson.read_jason() #initializes the save file if doesn't exist or just checking it out idk

func _on_Button2_pressed():
	pass # Replace with function body.

func _on_Button3_pressed():
	pass # Replace with function body.

func _on_Button4_pressed():
	get_tree().quit()
