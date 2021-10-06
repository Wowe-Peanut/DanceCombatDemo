extends Node2D

onready var dance_prefab = load("res://Objects/Dance.tscn")

var player_input = []
var max_dance_combo = 0
var dancing = true

func _ready():
	$Player.position = $PlayerSpawn.position
	
	
	generate_dances(3)
	get_max_dance_size()
	position_dances()

func generate_dances(count: int):
	randomize()
	for i in range(count):
		var dance = dance_prefab.instance()
		dance.combo_size = int(rand_range(4, 8))
		$DanceList.add_child(dance)

func get_max_dance_size():
	var max_combo = 0
	for d in $DanceList.get_children():
		max_combo = d.combo_size if max_combo < d.combo_size else max_combo
		
	max_dance_combo = max_combo

func _input(event):
	if player_input.size() > max_dance_combo || !dancing:
		player_input.clear()
		dancing = true
		update_dances()
		return
		
	if is_any_dance_completed():
		dancing = false
	
	if Input.is_action_just_pressed("ui_right"):
		player_input.append(0)
	elif Input.is_action_just_pressed("ui_up"):
		player_input.append(1)
	elif Input.is_action_just_pressed("ui_left"):
		player_input.append(2)
	elif Input.is_action_just_pressed("ui_down"):
		player_input.append(3)
		
	update_dances()

func is_any_dance_completed():
	for d in $DanceList.get_children():
		if d.is_complete:
			return true
	return false		
	

func update_dances():
	for d in $DanceList.get_children():
		d.update_arrows(player_input)
		
func _on_WorldBounds_body_entered(body):
	if body.name == "Player":
		body.position = $PlayerSpawn.position
	else:
		body.queue_free()

func position_dances():
	var y = 0
	for d in $DanceList.get_children():
		d.position.y = y
		y += 70


