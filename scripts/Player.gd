extends CharacterBody2D

const SPEED = 300.0

@onready var ai_controller = $Agent
@export var target: Node2D

func _ready() -> void:
	ai_controller.init(self)

func game_over() -> void:
	ai_controller.needs_reset = true
	ai_controller.done = true

func _physics_process(delta: float) -> void:
	if ai_controller.needs_reset:
		ai_controller.reset()
	
	var x_direction
	var y_direction
	
	if ai_controller.heuristic == "human":
		x_direction = Input.get_axis("ui_left", "ui_right")
		y_direction = Input.get_axis("ui_up", "ui_down")
	else:
		x_direction = ai_controller.x_direction
		y_direction = ai_controller.y_direction
	
	if x_direction:
		velocity.x = x_direction * SPEED
	else:
		velocity.x = 0

	if y_direction:
		velocity.y = y_direction * SPEED
	else:
		velocity.y = 0
		
	move_and_slide()

func get_target_position() -> Vector2:
	return target.global_position
