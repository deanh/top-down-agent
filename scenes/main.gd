extends Node2D

@export var tilemap: TileMap
@export var player: CharacterBody2D
@export var reward: Area2D

const TILE_SIZE = 32.0

var walkable_tile_pos = []

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	for pos in tilemap.get_used_cells(0):
		var td = tilemap.get_cell_tile_data(0, pos)
		if td.get_custom_data("Walkable"):
			walkable_tile_pos.append(pos)
	#print(walkable_tile_pos)
	reset()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func reset() -> void:
	place_random(player)
	place_random(reward)

func place_random(obj: Node2D) -> void:
	var place = walkable_tile_pos.pick_random()
	#print(place)
	obj.position = Vector2(float(place.x * TILE_SIZE), float(place.y * TILE_SIZE))
	
