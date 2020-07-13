extends Node2D

export(String) var next_level
export(String, MULTILINE) var hint
export(String, MULTILINE) var welcome_message

onready var _console = $GUI/DebugConsole/Console
onready var _console_writer = $GUI/DebugConsole
onready var _doors = $Doors
onready var _viruses = $Viruses
onready var _animation_player = $AnimationPlayer
onready var _lost_music_player = $LostSound
onready var _voice_player = $VoicePlayer
onready var _traps = $Traps
onready var _removers = $Removers


var _is_started = false
var _is_game_over = false
var _last_door_closed = null
var _is_lost = false

func _ready() -> void:
	_console_writer.write_line(welcome_message)
	
	# load [level1]
	var loadRef = CommandRef.new(self, "_load", 1)
	var loadCommand = ConsoleCommand.new("connect", loadRef, "Connect to the given computer (connect 1_boot)")
	_console.add_command(loadCommand)
	
	# start
	var startRef = CommandRef.new(self, "_start", 0)
	var startCommand = ConsoleCommand.new("boot", startRef, "Boot the computer (boot)")
	_console.add_command(startCommand)
	
	# reload
	var reloadRef = CommandRef.new(self, "_reload", 0)
	var reloadCommand = ConsoleCommand.new("restore", reloadRef, "Restore the computer (restore)")
	_console.add_command(reloadCommand)
	
	# hint
	var hintRef = CommandRef.new(self, "_hint", 0)
	var hintCommand = ConsoleCommand.new("hint", hintRef, "Give you hints about the current computer (hint)")
	_console.add_command(hintCommand)
	
	# open [d1]
	var openDoorRef = CommandRef.new(self, "_open_door", 1)
	var openDoorCommand = ConsoleCommand.new("open", openDoorRef, "Open the given door (open d1)")
	_console.add_command(openDoorCommand)
	
	# close [d1]
	var closeDoorRef = CommandRef.new(self, "_close_door", 1)
	var closeDoorCommand = ConsoleCommand.new("close", closeDoorRef, "Close the given door (close d1)")
	_console.add_command(closeDoorCommand)
	
	# rm [r1]
	var rmRef = CommandRef.new(self, "_rm", 1)
	var rmCommand = ConsoleCommand.new("rm", rmRef, "Removes all virus in the data storage (rm ds1)")
	_console.add_command(rmCommand)
	
	_animation_player.play("connect")
	_voice_player.play_connected()
	
	for antivirus in _traps.get_children():
		antivirus.connect("virus_killed", self, "_on_Virus_killed")
		
func _rm(id):
	id = id.to_lower()
	for ds in _removers.get_children():
		if ds.id == id:
			ds.remove()
			_console_writer.success("Data Storage '%s' removed." % id)		
			return
	_console_writer.error("Data Storage '%s' not found." % id)

func _on_Virus_killed():
	_voice_player.play_kill()

func _process(_delta: float) -> void:
	# If no more viruses, win give the next level name
	if _is_started and _viruses.get_child_count() == 0 and not _is_game_over:
		_win()
		
func _win() -> void:
	_is_game_over = true
	_console_writer.success("Virus infiltration neutralized.\n")
	_console_writer.error("New computer found : '%s'. Please connect." % next_level)
	_animation_player.play("win")
	_voice_player.play_win()

func _start() -> void:
	if _is_started:
		_console_writer.error("Computer already boot.")
	elif _viruses.get_child_count() == 0:
		_console_writer.error("You must connect to a computer to boot.")
	else:
		for virus in _viruses.get_children():
			virus.set_active(true)
			_is_started = true
		_console_writer.success("Booting... boot completed.")
		
func _load(level: String) -> void:
	var path = "res://Levels/%s.tscn" % level.to_lower()
	if File.new().file_exists(path):
		get_tree().change_scene(path)
		_animation_player.play("connect")
		_lost_music_player.stop()
		_console_writer.success("Connected to computer '%s'." % level)
		
	else:
		_console_writer.error("Computer '%s' was not found." % level)
		
func _reload() -> void:
	get_tree().reload_current_scene()
	_animation_player.play("connect")
	_lost_music_player.stop()
	
func _hint() -> void:
	_console_writer.success(hint)	
	
func _open_door(id: String) -> void:
	id = id.to_lower()
	for door in _doors.get_children():
		if door.id == id:
			if not door.is_open:
				door.open()
				if _last_door_closed == door:
					_last_door_closed = null
				_console_writer.success("Door '%s' open." % id)		
			else:
				_console_writer.warn("Door '%s' was already open." % id)
			return
	_console_writer.error("Door '%s' not found." % id)
	
func _close_door(id: String) -> void:
	id = id.to_lower()
	for door in _doors.get_children():
		if door.id == id:
			if door.is_open:
				if _last_door_closed:
					_console_writer.error("You can close only one door at a time. Please open door '%s'." % _last_door_closed.id)
					return	
				if not door.can_close:
					_console_writer.error("A virus is locking the door.")
					return
				door.close()
				_last_door_closed = door
				_console_writer.success("Door '%s' closed." % id)
			else:
				_console_writer.warn("Door '%s' was already closed." % id)
			return
	_console_writer.error("Door '%s' not found." % id)
	

func _on_Core_on_destroyed() -> void:
	_is_game_over= true
	_is_lost = true
	_animation_player.play("lost")
	_lost_music_player.play()
	_console_writer.error("System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system System out of control RESTORE the system")
	_voice_player.play_lost()

func _on_Console_error() -> void:
	_voice_player.play_errors()


func _on_Core2_on_destroyed() -> void:
	pass # Replace with function body.
