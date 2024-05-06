extends AIController2D

@onready var x_direction: float = 0
@onready var y_direction: float = 0.
@onready var acc_reward: float = 0.
@onready var level = get_node("/root/Main")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if n_steps % 20 == 0:
		_player.old_location = _player.position
	if n_steps % 500 == 0:
		#var relative = to_local(_player.get_target_position())
		print("steps ", n_steps)
		#print("dist ", relative.length())
		print("reward ", acc_reward)

func get_obs() -> Dictionary:
	#var relative = to_local(_player.get_target_position())
	var obs = [_player.position.x, _player.position.y]
	var raycast_obs = _player.raycast_sensor.get_observation()
	#obs.append_array(raycast_obs)
	return {"obs": obs}
	
func get_reward() -> float:
	var relative = to_local(_player.get_target_position())
	var scaled_dist = relative.length() / level.TILE_SIZE
	var reward = 0
	
	if scaled_dist < 2:
		reward += 100
		
	if to_local(_player.old_location).length() / level.TILE_SIZE < 3:
		reward -= 1
		
	acc_reward += reward
	return reward
	
func get_action_space() -> Dictionary:
	return {
		"move_action": {
			"size": 2,
			"action_type": "continuous"
		}
	}

func set_action(action) -> void:
	x_direction = clamp(action["move_action"][0], -1.0, 1.0)
	y_direction = clamp(action["move_action"][1], -1.0, 1.0)
	
func reset():
	n_steps = 0
	needs_reset = false
	level.reset()
