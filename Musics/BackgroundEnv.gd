extends AudioStreamPlayer2D

export(AudioStream) var loop;


# Called when the node enters the scene tree for the first time.
func _process(delta):
	if not playing:
		stream = loop
		play()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
