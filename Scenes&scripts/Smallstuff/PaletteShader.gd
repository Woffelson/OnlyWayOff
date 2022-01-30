extends Node2D

var source #get asset...
var out #biomi
var debug = true
var varit = {"musta": Vector3(31,31,31)/255,
	"tharmaa": Vector3(63,63,63)/255,
	"harmaa": Vector3(124,124,124)/255,
	"vharmaa": Vector3(175,169,169)/255,
	"valkoinen": Vector3(216,216,216)/255,
	"tsyaani": Vector3(37,77,93)/255,
	"syaani": Vector3(53,129,137)/255,
	"syaanii": Vector3(87,126,132)/255,
	"vsyaani": Vector3(76,211,213)/255,
	"tsininen": Vector3(44,42,170)/255,
	"sininen": Vector3(58,119,209)/255,
	"vsininen": Vector3(85,170,211)/255,
	"tvioletti": Vector3(79,63,169)/255,
	"violetti": Vector3(108,87,209)/255,
	"vvioletti": Vector3(144,119,210)/255,
	"tmagenta": Vector3(135,35,130)/255,
	"magenta": Vector3(188,40,181)/255,
	"vmagenta": Vector3(206,169,192)/255,
	"tpunainen": Vector3(130,47,38)/255,
	"punainenn": Vector3(152,40,40)/255,
	"punainen": Vector3(170,31,33)/255,
	"ruskea": Vector3(87,65,36)/255,
	"oranssi": Vector3(192,100,60)/255,
	"voranssi": Vector3(210,116,98)/255,
	"tkeltainen": Vector3(154,123,54)/255,
	"keltainen": Vector3(211,164,68)/255,
	"vkeltainen": Vector3(212,193,164)/255,
	"tvihree": Vector3(42,105,44)/255,
	"vihree": Vector3(55,152,58)/255,
	"vvihree": Vector3(168,209,80)/255,
	"tpuntest": Vector3(127,0,0)/255,
	"puntest": Vector3(191,0,0)/255,
	"vpuntest": Vector3(255,0,0)/255}
var soossi = {"soossi_0": varit["musta"],#pohja
	"soossi_1": varit["tharmaa"],#tumma
	"soossi_2": varit["harmaa"],#haalea
	"soossi_3": varit["vharmaa"],#vaalea
	"soossi_4": varit["valkoinen"],#valkea
	"soossi_5": varit["tpuntest"],#tummaväri
	"soossi_6": varit["puntest"],#perusväri
	"soossi_7": varit["vpuntest"]#vaaleavari
}
var biomit = {
	"testibiom": {"uloste_0": varit["musta"],#0
		"uloste_1": varit["tharmaa"],
		"uloste_2": varit["tvioletti"],
		"uloste_3": varit["violetti"],
		"uloste_4": varit["vvioletti"],
		"uloste_5": varit["tmagenta"],
		"uloste_6": varit["magenta"],
		"uloste_7": varit["vmagenta"]},
	"mustavalko": {"uloste_0": varit["musta"],#1
		"uloste_1": varit["tharmaa"],
		"uloste_2": varit["harmaa"],
		"uloste_3": varit["vharmaa"],
		"uloste_4": varit["valkoinen"],
		"uloste_5": varit["tharmaa"],
		"uloste_6": varit["harmaa"],
		"uloste_7": varit["vharmaa"]},
	"umbra": {"uloste_0": varit["musta"],#2
		"uloste_1": varit["tharmaa"],
		"uloste_2": varit["tsyaani"],#harmaa
		"uloste_3": varit["syaanii"],#vharmaa
		"uloste_4": varit["vharmaa"],#valkoinen
		"uloste_5": varit["ruskea"],
		"uloste_6": varit["tkeltainen"],
		"uloste_7": varit["vkeltainen"]},
	"keltaranta": {"uloste_0": varit["musta"],#3
		"uloste_1": varit["tsyaani"],
		"uloste_2": varit["syaani"],
		"uloste_3": varit["vsininen"],
		"uloste_4": varit["vsyaani"],
		"uloste_5": varit["tkeltainen"],
		"uloste_6": varit["keltainen"],
		"uloste_7": varit["vkeltainen"]},
	"ikivihree": {"uloste_0": varit["musta"],#4
		"uloste_1": varit["tharmaa"],
		"uloste_2": varit["tsyaani"],
		"uloste_3": varit["syaani"],
		"uloste_4": varit["vsyaani"],
		"uloste_5": varit["tvihree"],
		"uloste_6": varit["vihree"],
		"uloste_7": varit["vvihree"]},
	"sinihetki": {"uloste_0": varit["tharmaa"],#5 tharmaa/tsyaani
		"uloste_1": varit["musta"],
		"uloste_2": varit["tharmaa"],
		"uloste_3": varit["harmaa"],
		"uloste_4": varit["voranssi"],
		"uloste_5": varit["tsyaani"],
		"uloste_6": varit["syaani"],
		"uloste_7": varit["vsininen"]},
	"liila": {"uloste_0": varit["tsyaani"],#6 tharmaa
		"uloste_1": varit["musta"],
		"uloste_2": varit["tharmaa"],
		"uloste_3": varit["sininen"],#violetti
		"uloste_4": varit["vsyaani"],
		"uloste_5": varit["tvioletti"],
		"uloste_6": varit["violetti"],
		"uloste_7": varit["vsininen"]},
	"punamulta": {"uloste_0": varit["tharmaa"],#7 ruskea
		"uloste_1": varit["musta"],
		"uloste_2": varit["tharmaa"],
		"uloste_3": varit["tpunainen"],
		"uloste_4": varit["vmagenta"],
		"uloste_5": varit["ruskea"],
		"uloste_6": varit["punainenn"],
		"uloste_7": varit["voranssi"]},
	"inferno": {"uloste_0": varit["musta"], #8
		"uloste_1": varit["tharmaa"],
		"uloste_2": varit["ruskea"],
		"uloste_3": varit["tkeltainen"],
		"uloste_4": varit["vkeltainen"],
		"uloste_5": varit["tpunainen"],
		"uloste_6": varit["punainen"],
		"uloste_7": varit["oranssi"]},
	"pastelli": {"uloste_0": varit["musta"], #9
		"uloste_1": varit["tsyaani"],
		"uloste_2": varit["syaani"],
		"uloste_3": varit["magenta"],
		"uloste_4": varit["vmagenta"],
		"uloste_5": varit["tmagenta"],
		"uloste_6": varit["oranssi"],
		"uloste_7": varit["vkeltainen"]},
	"ikirouta": {"uloste_0": varit["musta"], #10
		"uloste_1": varit["tsyaani"],
		"uloste_2": varit["syaanii"],
		"uloste_3": varit["sininen"],
		"uloste_4": varit["vmagenta"],
		"uloste_5": varit["vsininen"],#valkoinen
		"uloste_6": varit["valkoinen"],#vsininen
		"uloste_7": varit["vsyaani"]}
}

func _ready():
	setup(1)
	
func _input(_event):
	if Input.is_action_just_pressed("ui_home") && debug:
		change_set("debug")

func change_set(biomi_id):
	if biomi_id == "debug": #debug scrolling through every palette
		for biomi in len(biomit.keys()):
			if out == biomit.keys()[biomi]:
				if biomi+1 >= len(biomit.keys()):
					out = biomit.keys()[0]
				else: 
					out = biomit.keys()[biomi+1]
					break
	else: out = biomi_id #use the relevant name specified in biome palette dictionary (biomit)!
	setup(null)
	#sheidi(source,biomit[out])

func setup(biom_key):
	if biom_key != null:
		out = biomit.keys()[biom_key]#0 "testibiom"
	for graffat in get_children():
		source = graffat
		sheidi(source,biomit[out])

func sheidi(spr,ulos):
	for i in 8:
		var soos = "soossi_"+String(i)
		var poop = "uloste_"+String(i)
		spr.material.set_shader_param(soos, soossi[soos])
		spr.material.set_shader_param(poop, ulos[poop])
