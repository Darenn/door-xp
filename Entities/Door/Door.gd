extends KinematicBody2D

export(String) var id = "d1"

var is_open = true
var can_close = true

func _ready() -> void:
	$CollisionShape2D.disabled = true
	$SpriteDoorOpen.visible = true
	$SpriteDoorClosed.visible = false
	$Label.text = id

func close() -> void:
	$CollisionShape2D.disabled = false
	$SpriteDoorOpen.visible = false
	$SpriteDoorClosed.visible = true
	is_open = false
	
func open() -> void:
	$CollisionShape2D.disabled = true
	$SpriteDoorOpen.visible = true
	$SpriteDoorClosed.visible = false
	is_open = true


func _on_DetectionArea_area_entered(area: Area2D) -> void:
	can_close = false


func _on_DetectionArea_area_exited(area: Area2D) -> void:
	can_close = true
