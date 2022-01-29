extends Node #this script handles the json format save file

var jason = "res://game.json" #json file path, change in finished gamed into: user://data.json
var d = {}
var default_d = {"position":[512,168]} #default values

func read_jason(): #load
	var file = File.new()
	if not file.file_exists(jason):
		reset_data() #back to default
		return
	file.open(jason, file.READ)
	var t = file.get_as_text()
	#d = JSON.print(parse_json(t))
	d = parse_json(t)
	file.close()
	return d
	
func write_jason(): #save
	var file
	file = File.new()
	file.open(jason, file.WRITE)
	file.store_line(to_json(d))
	file.close()
	
func delete_jason(): #erase
	var dir = Directory.new()
	dir.remove(jason)
	reset_data()
	
func reset_data():
	d = default_d.duplicate(true)

func save_data(pos): #determines all the exact stuff to be saved
	d["position"] = pos
	write_jason()

func load_data(player): #loads all the relevant stuff for the game itself
	read_jason()
	player.position.x = d["position"][0]
	player.position.y = d["position"][1]
