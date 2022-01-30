extends Area2D

onready var spr = $Spr

signal lit(biomi)

func _on_Lampp_area_entered(area):
	if area.is_in_group("Valo"):
		spr.animation = "on"
		emit_signal("lit",6)

func _on_Lampp_body_entered(body):
	if body.is_in_group("Valo"):
		spr.animation = "on"
		emit_signal("lit",6)
