extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	

func _on_Core_area_entered(area: Area2D) -> void:
	queue_free()
	area.owner.queue_free()
