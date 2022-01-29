extends Panel

onready var rtext = $TekstiKontti/RText
onready var timer = $TekstiKontti/RText/Timer

var typewrite_spede = 0.05
var font
var altfont = false #controls the use of bbcode monospace which has unifont set (FOR NOW at least)

func _ready():
	if altfont: rtext.push_mono() #push_font() would make more sense...
	rtext.set_visible_characters(0) #no characters
	rtext.set_percent_visible(0) #not even a portion

func _on_Timer_timeout():
	if rtext.percent_visible >= 1:
		timer.stop()
	elif rtext.percent_visible < 1:
		rtext.set_percent_visible(rtext.get_percent_visible()+typewrite_spede)
