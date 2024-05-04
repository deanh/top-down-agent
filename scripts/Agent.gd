extends AIController2D

@onready var x_direction: float = 0
@onready var y_direction: float = 0.
@onready var acc_reward: float = 0.

const TILE_SIZE = 32 

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if n_steps % 500 == 0:
		var relative = to_local(_player.get_target_position())
		print("steps ", n_steps)
		print("dist ", relative.length())
		print("reward ", acc_reward)

func get_obs() -> Dictionary:
	var relative = to_local(_player.get_target_position())
	var obs = [relative.x, relative.y]
	
	return {"obs": obs}
	
func get_reward() -> float:
	var relative = to_local(_player.get_target_position())
	var reward = -(relative.length() / TILE_SIZE) ** 2
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
	
