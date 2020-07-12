extends AudioStreamPlayer2D

export(Array, AudioStream) var kill_virus_sounds
export(Array, AudioStream) var connected_sounds
export(Array, AudioStream) var errors
export(Array, AudioStream) var lost
export(Array, AudioStream) var win
export(Array, AudioStream) var restore

func _play_random_sound(array):
	stream = array[randi() % array.size()]
	play()
	
func play_kill():
	_play_random_sound(kill_virus_sounds)
	
func play_connected():
	_play_random_sound(connected_sounds)
	
func play_errors():
	_play_random_sound(errors)
	
func play_lost():
	_play_random_sound(lost)
	
func play_win():
	_play_random_sound(win)
	
func play_restore():
	_play_random_sound(restore)
