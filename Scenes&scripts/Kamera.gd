extends Camera2D

var gui = 1 #0: gui offset disabled, 1: gui offset enabled
var guioffset = 128
var offsetit = [128,64]

signal room_change(pos,scl)

func _ready():
	pass # Replace with function body.

#func _process(_delta):
#	zoomer(self)

func _on_Area2D_area_entered(area):
	#siirtyma() #transition in
	var collision_shape = area.get_node("CollisionShape2D")
	var size = collision_shape.shape.extents*area.scale #old: area.get_parent().scale
	zoomer(area)
#	var view_size = get_viewport_rect().size #???
#	if size.y < view_size.y: #small rooms will be centered in view, or something like that...
#		size.y = view_size.y
#	if size.x < view_size.x:
#		size.x = view_size.x
	if zoom.x < 1: #WATCH OUT, PURKKA AHEAD!
		limit_top = collision_shape.position.y+area.position.y - size.y +guioffset*gui
	else:
		limit_top = collision_shape.position.y+area.position.y - size.y #original...
	limit_left = collision_shape.position.x+area.position.x - size.x
	limit_bottom = limit_top + size.y*2 +guioffset*gui
	limit_right = limit_left + size.x*2
	emit_signal("room_change",Vector2(limit_left,limit_top),area.scale)

func _siirtyma(): #transition between rooms, not gonna use in this project I guess...
	get_tree().paused = true
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().paused = false

func zoomer(area):
	if (area.scale.x < 1 || area.scale.y < 1) || (Input.is_action_pressed("ui_end")):
		zoom = Vector2(0.5,0.5)
		guioffset = offsetit[1]
		#offset.y = guioffset #still a bit ad hoc purkka solution, but oh well...
	elif area != self:
		zoom = Vector2(1,1)
		guioffset = offsetit[0]
		#offset.y = 0 #yea, no offsets pls
