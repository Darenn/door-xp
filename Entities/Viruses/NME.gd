extends Node2D

class_name NME

export(Vector2) var starting_direction = Vector2.DOWN
export(int) var speed = 50

var is_active = false

onready var _direction = starting_direction

var _available_directions = [Vector2.DOWN, Vector2.UP, Vector2.RIGHT, Vector2.LEFT]

func _ready() -> void:
	pass # Replace with function body.
	

func _physics_process(delta: float) -> void:
	_available_directions = [Vector2.DOWN, Vector2.UP, Vector2.RIGHT, Vector2.LEFT]
	if $AreaDown.get_overlapping_bodies().size() > 0:
		_available_directions.erase(Vector2.DOWN)
		
	if $AreaLeft.get_overlapping_bodies().size() > 0:
		_available_directions.erase(Vector2.LEFT)
		
	if $AreaUp.get_overlapping_bodies().size() > 0:
		_available_directions.erase(Vector2.UP)
		
	if $AreaRight.get_overlapping_bodies().size() > 0:
		_available_directions.erase(Vector2.RIGHT)
		

func _process(delta: float) -> void:
	if not is_active:
		return
	# If we detect a wall in our current direction, change direction
	if not _available_directions.has(_direction):
		var old_direction = _direction
		var favorite_directions = _available_directions.duplicate()
		# Avoid turn down
		favorite_directions.erase(-_direction)
		if favorite_directions.size() == 0:
			favorite_directions = _available_directions.duplicate()
		if favorite_directions.size() > 0:
			_direction = favorite_directions[randi() % favorite_directions.size()]
		else:
			_direction = old_direction
	position += _direction * speed * delta

func set_active(value: bool) -> void:
	is_active = value
	

#func _on_AreaRight_body_entered(body: Node) -> void:
#	_available_directions.erase(Vector2.RIGHT)
#
#
#func _on_AreaRight_body_exited(body: Node) -> void:
#	_available_directions.append(Vector2.RIGHT)
#
#
#func _on_AreaLeft_body_entered(body: Node) -> void:
#	_available_directions.erase(Vector2.LEFT)
#
#
#func _on_AreaLeft_body_exited(body: Node) -> void:
#	_available_directions.append(Vector2.LEFT)
#
#
#func _on_AreaUp_body_entered(body: Node) -> void:
#	_available_directions.erase(Vector2.UP)
#
#
#func _on_AreaUp_body_exited(body: Node) -> void:
#	_available_directions.append(Vector2.UP)
#
#
#func _on_AreaDown_body_entered(body: Node) -> void:
#	_available_directions.erase(Vector2.DOWN)
#
#
#func _on_AreaDown_body_exited(body: Node) -> void:
#	_available_directions.append(Vector2.DOWN)
