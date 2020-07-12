extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	yield(get_tree().create_timer(7.0), "timeout")
	get_tree().change_scene("res://main.tscn")


