extends Node2D

onready var arrow_prefab = load("res://Objects/Arrow.tscn")
var dance_combo = []
var arrow_spacing = 75
var combo_size = 4


var is_complete = false

func _ready():
	get_random_combo(combo_size)
	draw_arrows()
	





func update_arrows(input: Array):
	var comboing = true
	var color
	for i in range(dance_combo.size()):
		if i >= input.size():
			comboing = false
			color = Color(1, 1, 1)
		else:
			if input[i] == dance_combo[i] && comboing:
				color = Color(1, 0, 0)
			else:
				comboing = false
				color = Color(0, 0, 0)
		
		$Arrows.get_children()[i].modulate = color
		
	is_complete = comboing

func get_random_combo(length: int):
	randomize()
	var combo = []
	for c in range(length):
		combo.append(int(rand_range(0, 4)))
		
	dance_combo = combo

func draw_arrows():
	var x = 0
	for c in dance_combo:
		var arrow = arrow_prefab.instance()
		arrow.rotation_degrees = 360-(c*90)
		arrow.position.x = x
		$Arrows.add_child(arrow)
		x += arrow_spacing



