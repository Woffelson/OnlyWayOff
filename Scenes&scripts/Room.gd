extends Area2D

export var biomi = 1 #for room based shader setup
var portti = null #port should be opened by lit lamp in same room

func lighten(b):
	$Light2D.hide() #hide the darkener light node
	biomi = b
	portti.position.y -= 64

func _on_Room_area_entered(area):
	if area.is_in_group("Lamppu"):
		area.connect("lit",self,"lighten")
		area.room = self

func _on_Room_body_entered(body):
	if body.is_in_group("port"):
		portti = body
