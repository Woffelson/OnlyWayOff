extends KinematicBody2D

const speed = 480/2

signal moving(pos)

func _physics_process(delta: float) -> void:
	emit_signal("moving",position)
	var dir = Vector2(Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left"),
		Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up"))
		
	move_and_slide(dir.normalized() * speed)
