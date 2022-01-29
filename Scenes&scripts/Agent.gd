extends KinematicBody2D

onready var timer = $Timer

const TEST = true
var MAXSPD = 250
var ACCEL = 50
var JUMP = 500
var FALLCAP = 800
#const JUMPMAX = 100
var GRAV = 80
var FRIC = 40
var GLIDE = 0#9
var fallcap = 800
var hor = 0; var ver = 0; var dir = -1 #active and passive direction variables
var motion = Vector2()
var ground_xy = Vector2() #memorized position when fallen
var helth = [10,10] #real/max
var real_parent = null
var player = true#false
var target = null
var approach_range = Vector2(8,64) #threshold for bots to stop following in xy directions
var kiertoaika = 1
var in_liquid = false

signal moving(posi)

func test():
	if TEST:
		target = get_global_mouse_position()

func _ready():
	randomize()
	if !player: timer.start(kiertoaika)
#	$Timer.start(0.5)
#	dir = 1
#	gunpos = pos.position #get the gun's position and initialize as basis

func _physics_process(_delta):
	test()
	if is_on_floor(): ground_xy = position #remember where you were
	fysiks()
	motion = move_and_slide(motion,Vector2.UP)
	if player: #does following code work after move_and_slide??? -yes, I guess
		emit_signal("moving",position) #for camera
		hor = int(Input.is_action_pressed("key_right")) - int(Input.is_action_pressed("key_left"))
		Jump(Input.is_action_just_pressed("key_up"),Input.is_action_pressed("key_up"))
		Down(Input.is_action_pressed("key_down"),2) #drop down one-way block
	else: #BOTS/NPC!!!
		if target != null: #if there's target to follow
			if abs(position.x-target.x) > approach_range.x: #target.position
				hor = -sign(position.x-target.x) #.position
			else: hor = 0 #stop moving when threshold reached
			if abs(position.y-target.y) > approach_range.y: #.position
				ver = -sign(position.y-target.y) #.position
			else: ver = 0 #stop jumping/dropping when threshold reached
		if abs(hor) > 0 && motion.x == 0: ver = -1 #this has to be after move_and_slide I guess... replace with raycast to fix bunny hopping
		#else: ver = 0 #...if abs(hor) > 0 || target = null...
		if ver > 0: Down(true,2)
		else:
			Down(false,2)
			if ver < 0: Jump(true,true)

func fysiks():
	if abs(hor) > 0: dir = hor #dir= -1or1 (position.angle_to_point(get_global_mouse_position()))
	if abs(motion.x) < MAXSPD: #basic movement sideways
		motion.x += hor*ACCEL
	if abs(motion.x) > 0 && hor != sign(motion.x): # && is_on_floor() # hor == 0
		motion.x -= min(abs(motion.x),FRIC)*sign(motion.x) #sliding after movement
	if motion.y < fallcap && !is_on_floor(): motion.y += GRAV #falling
	else: motion.y += 1 #falling
	if abs(motion.x) > MAXSPD: motion.x = MAXSPD*sign(motion.x) #horizontal cap
	#if is_on_floor(): FRIC = 20; else: FRIC = 0 #Comment this if you want to move in the air!!!!!

func Jump(trigger,hold): #might need prevention conditions when hurt etc
	if trigger: #initial jump
		if in_liquid: motion.y = -JUMP/2 #swim
		elif is_on_floor(): motion.y = -JUMP #elif jumps[0]
	if hold: #constant jump/flying/etc.
		if motion.y > 0 && GLIDE > 0:#going down
			motion.y -= GLIDE
			fallcap = FALLCAP/20#25
		else: #going up
			fallcap = FALLCAP
			GRAV = 20
	else: 
		GRAV = 40
		fallcap = FALLCAP

func Down(tester,layer):
	if tester:
		set_collision_mask_bit(layer,false)
	else: set_collision_mask_bit(layer,true)

func detection(one_to_be_detected,detect_range): #distance based detection, alt: raycast, simple alarm trig?
	if one_to_be_detected != null:
#		if (position-detected.position).length() < detect_range:
#			return true
#		else: return false
		var tmp = (position-one_to_be_detected.position) #get the distance
		if abs(tmp.x) < detect_range && abs(tmp.y) < detect_range/2: return true
		else: return false #if out of bounadirues

func instance_create(obj,x,y):
	var id = obj.instance()
	add_child(id) #ysort.
	id.position = Vector2(x,y)
	return id

func kierto():
	if !player && target == null: 
		hor = round(rand_range(-1,1))
		ver = round(rand_range(-1,1))
	#print(ver)
	timer.start(kiertoaika)

func _on_Timer_timeout():
	timer.stop() #needed or not?
	if !player: kierto()

func _on_BottomColl_area_entered(_area): #in liquid
	#movez.inliquid()
	MAXSPD = 50
	ACCEL = 20
	#JUMP = 500/4
	FALLCAP = 50 #50 for water, 1 for swamp/moss
	#GRAV = 10
	#FRIC = 5
	in_liquid = true
	motion.y = 0 #...?

func _on_BottomColl_area_exited(_area): #out liquid
	#movez.outliquid()
	MAXSPD = 100
	ACCEL = 50
	JUMP = 500/2
	FALLCAP = 400
	#GRAV = 20
	FRIC = 20#40
	in_liquid = false
