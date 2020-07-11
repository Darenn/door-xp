extends Area2D


func _on_BlackHole_area_entered(area: Area2D) -> void:
	area.owner.queue_free()
	queue_free()
