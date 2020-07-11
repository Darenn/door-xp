extends KinematicBody2D

export(String) var id = "d1"

func _ready() -> void:
	$CollisionShape2D.disabled = true
	$SpriteDoorOpen.visible = true
	$SpriteDoorClosed.visible = false

func activate() -> void:
	$CollisionShape2D.disabled = false
	$SpriteDoorOpen.visible = false
	$SpriteDoorClosed.visible = true
	
func deactivate() -> void:
	$CollisionShape2D.disabled = true
	$SpriteDoorOpen.visible = true
	$SpriteDoorClosed.visible = false
