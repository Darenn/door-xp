extends Area2D

export(String) var id = "ds1"

func _ready() -> void:
	$CollisionShape2D.disabled = true
	$RichTextLabel.text = id

func remove():
	$CollisionShape2D.disabled = false
	yield(get_tree().create_timer(0.1), "timeout")
	queue_free()
	

func _on_Remover_area_entered(area: Area2D) -> void:
	queue_free()
	area.owner.queue_free()
