extends Control

onready var pla = preload("res://Scenes&scripts/Player.tscn")
onready var kam = preload("res://Scenes&scripts/Kamera.tscn")
onready var start = $Start.position
#onready var jason = preload("res://jason.gd")

var gridi = null
var plaa = null
var huonehahmot = []
var cam = null
var chain = true #whether camera is chained to player or something else
#var jansson = null

func _ready():
	#plaa = create_character(pla,start,ysort,true) #player
	plaa = instance_create(pla,start,self)
	plaa.connect("moving",self,"cam_position")
	#create_character(pla,start+Vector2(128,32),ysort,false) #npc
	cam = instance_create(kam,start,self)
	cam.connect("room_change",self,"skaalaa")
	#jansson.load_data(plaa) #makes the saved game or default values work right away

#func _process(delta):
#	if Input.is_action_just_pressed("ui_page_up"):
#		jansson.save_data([plaa.position.x,plaa.position.y])
#	if Input.is_action_just_pressed("ui_page_down"):
#		jansson.load_data(plaa)
#	if Input.is_action_just_pressed("ui_end"):
#		jansson.delete_jason()

func instance_create(obj,xy,creator):
	var id = obj.instance()
	creator.add_child(id) #ysort is one good idea for creator
	id.position = xy#Vector2(x,y)
	return id
	
func cam_position(pos):
	if chain:#cam != null:
		cam.position = pos
	else: cam.position = get_local_mouse_position() #could be something else too...

func skaalaa(pos,scl): #???
	if gridi != null:
		gridi.grid_pos = pos#+Vector2(64,64)
		gridi.grid_size = Vector2(16,8) * scl
