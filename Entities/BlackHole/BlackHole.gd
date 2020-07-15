extends Area2D

class_name AntiVirus

signal virus_killed

func _on_BlackHole_area_entered(area: Area2D) -> void:
	if area.is_in_group("Virus"):
		area.owner.queue_free()
		emit_signal("virus_killed")
		queue_free()

