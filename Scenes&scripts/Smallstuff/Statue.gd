extends Area2D

onready var left = $LeftEye
onready var right = $RightEye
onready var timer = $Timer

var eyepos = [] #set default values here
var player = null
var tekstigui = null
export var slogan = "haist vit"

signal say(something)

func _ready():
	#tekstigui = get_node("/root/MainMenu/MainView/VBoxContainer/KonttiGUI/CanvasLayer/DisplayText/HSplit/TextItself")
	eyepos.append(left.position)
	eyepos.append(right.position)
	#player = get_tree().get_root().find_node("Agent") #not work stupid

func _process(_delta):
	if player != null:
		left.position.x = eyepos[0].x - sign(position.x-player.position.x)
		left.position.y = eyepos[0].y - sign(position.y-75-player.position.y)
		right.position.x = eyepos[1].x - sign(position.x-player.position.x)
		right.position.y = eyepos[1].y - sign(position.y-75-player.position.y)

func hibernate(): #when loses the player on sight or something
	player = null
	left.hide()
	right.hide()

func _on_Statue_body_entered(body):
	if body.is_in_group("Agent"):
		if player == null:
			$Moi.play()
			left.show()
			right.show()
			#tekstigui.rtext.bbcode_text = slogan #alt1 "getnode purkka"
			#emit_signal("say",slogan) #alt2 signal
			tekstigui = find_parent("MainMenu").tekstigui #alt3 find (only common parent can help)
			tekstigui.rtext.bbcode_text = slogan
			tekstigui.reset()
		player = body

func _on_Timer_timeout():
	if player != null:
		if randi() % 20 == 1:
			left.hide()
			right.hide()
		else:
			left.show()
			right.show()
