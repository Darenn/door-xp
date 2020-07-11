extends KinematicBody2D

var direction = Vector2.DOWN
var speed = 50

func _ready() -> void:
	pass # Replace with function body.

func _process(delta: float) -> void:
	var collision: KinematicCollision2D = move_and_collide(direction * speed * delta)
	if collision:
		var collision_direction = (collision.position - position).normalized()
		if abs(collision.position.x) > abs(collision.position.y):
			direction = _get_random_direction([Vector2.LEFT, Vector2.RIGHT])
#			if collision.position.x < 0:
#				position.x += 2
#			if collision.position.x > 0:
#				position.x -= 2
		else:
			direction = _get_random_direction([Vector2.UP, Vector2.DOWN])
#			if collision.position.y > 0:			
#				position.y -= 2
#			if collision.position.y < 0:
#				position.y += 2
	

func _get_random_direction(directions_to_avoid:= [Vector2.ZERO]):
	var directions = [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]
	var favorite_directions = []
	for direction in directions:
		if not directions_to_avoid.has(direction):
			favorite_directions.append(direction)
	return directions[randi() % directions.size()]
