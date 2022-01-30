extends Area2D

onready var spr = $Spr

var shaderi = null
var room = null #room should set this by itself...

signal lit(biomi)

func _ready():
	shaderi = get_node("/root/MainMenu/MainView/VBoxContainer/KonttiPeli/GameMain/Navigation2D/PaletteShader")

#func _on_Lampp_area_entered(area):
#	if area.is_in_group("Valo"):
#		spr.animation = "on"
#		emit_signal("lit",9)

func _on_Lampp_body_entered(body):
	if body.is_in_group("Valo"):
		spr.animation = "on"
		emit_signal("lit",9)
		shaderi.setup(9)
		#get_parent
