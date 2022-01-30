extends Area2D

export var biomi = 1 #for room based shader setup

func lighten(b):
	$Light2D.hide() #hide the darkener light node
	biomi = b

func _on_Room_area_entered(area):
	if area.is_in_group("Lamppu"):
		area.connect("lit",self,"lighten")
