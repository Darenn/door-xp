extends Node2D

var _direction = Vector2.DOWN
var speed = 50

var _available_directions = [Vector2.DOWN, Vector2.UP, Vector2.RIGHT, Vector2.LEFT]

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	# If we detect a wall in our current direction, change direction
	if not _available_directions.has(_direction):
		var favorite_directions = _available_directions.duplicate()
		# Avoid turn down
		favorite_directions.erase(-_direction)
		if favorite_directions.size() == 0:
			favorite_directions = _available_directions.duplicate()
		_direction = favorite_directions[randi() % favorite_directions.size()]
	position += _direction * speed * delta


func _on_AreaRight_body_entered(body: Node) -> void:
	_available_directions.erase(Vector2.RIGHT)


func _on_AreaRight_body_exited(body: Node) -> void:
	_available_directions.append(Vector2.RIGHT)


func _on_AreaLeft_body_entered(body: Node) -> void:
	_available_directions.erase(Vector2.LEFT)


func _on_AreaLeft_body_exited(body: Node) -> void:
	_available_directions.append(Vector2.LEFT)


func _on_AreaUp_body_entered(body: Node) -> void:
	_available_directions.erase(Vector2.UP)


func _on_AreaUp_body_exited(body: Node) -> void:
	_available_directions.append(Vector2.UP)


func _on_AreaDown_body_entered(body: Node) -> void:
	_available_directions.erase(Vector2.DOWN)


func _on_AreaDown_body_exited(body: Node) -> void:
	_available_directions.append(Vector2.DOWN)
