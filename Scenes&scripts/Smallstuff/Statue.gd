extends Area2D

onready var left = $LeftEye
onready var right = $RightEye
onready var timer = $Timer

var eyepos = [] #set default values here
var player = null
export var slogan = "haist vit"

func _ready():
	eyepos.append(left.position)
	eyepos.append(right.position)
	#player = get_tree().get_root().find_node("Agent") #not work stupid

func _process(_delta):
	if player != null:
		left.position.x = eyepos[0].x - sign(position.x-player.position.x)
		left.position.y = eyepos[0].y - sign(position.y-75-player.position.y)
		right.position.x = eyepos[1].x - sign(position.x-player.position.x)
		right.position.y = eyepos[1].y - sign(position.y-75-player.position.y)

func _on_Statue_body_entered(body):
	if body.is_in_group("Agent"):
		if player == null:
			$Moi.play()
			left.show()
			right.show()
		player = body

func _on_Timer_timeout():
	if player != null:
		if randi() % 20 == 1:
			left.hide()
			right.hide()
		else:
			left.show()
			right.show()
