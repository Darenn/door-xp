extends Area2D

signal on_destroyed

func _on_Core_area_entered(area: Area2D) -> void:
	queue_free()
	area.owner.queue_free()
	emit_signal("on_destroyed")
