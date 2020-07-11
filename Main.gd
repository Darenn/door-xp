extends Node2D

export(String) var next_level

onready var _console = $GUI/DebugConsole/Console
onready var _console_writer = $GUI/DebugConsole
onready var _doors = $Doors
onready var _viruses = $Viruses

var _is_started = false
var _is_game_over = false
var _last_door_closed = null

func _ready() -> void:
	# start
	var startRef = CommandRef.new(self, "_start", 0)
	var startCommand = ConsoleCommand.new("start", startRef, "Start the loaded level.")
	_console.add_command(startCommand)
	
	# load [level1]
	var loadRef = CommandRef.new(self, "_load", 1)
	var loadCommand = ConsoleCommand.new("load", loadRef, "Load the given level.")
	_console.add_command(loadCommand)
	
	# reload
	var reloadRef = CommandRef.new(self, "_reload", 0)
	var reloadCommand = ConsoleCommand.new("reload", reloadRef, "Reload the current level.")
	_console.add_command(reloadCommand)
	
	# open_door [d1]
	var openDoorRef = CommandRef.new(self, "_open_door", 1)
	var openDoorCommand = ConsoleCommand.new("open_door", openDoorRef, "Open the given door (id).")
	_console.add_command(openDoorCommand)
	
	# close_door [d1]
	var closeDoorRef = CommandRef.new(self, "_close_door", 1)
	var closeDoorCommand = ConsoleCommand.new("close_door", closeDoorRef, "Close the given door (id).")
	_console.add_command(closeDoorCommand)

func _process(delta: float) -> void:
	# If no more viruses, win give the next level name
	if _is_started and _viruses.get_child_count() == 0 and not _is_game_over:
		_win()
	
func _win() -> void:
	_is_game_over = true
	_console_writer.success("You won! Next level is : '%s'." % next_level)

func _start() -> void:
	if _is_started:
		_console_writer.error("Level has already started.")
	else:
		for virus in _viruses.get_children():
			virus.set_active(true)
			_is_started = true
		_console_writer.success("Level started.")
		
func _load(level: String) -> void:
	var path = "res://Levels/%s.tscn" % level.to_lower()
	if File.new().file_exists(path):
		get_tree().change_scene(path)
		_console_writer.success("Level '%s' was loaded." % level)
	else:
		_console_writer.error("Level '%s' was not found." % level)
		
func _reload() -> void:
	get_tree().reload_current_scene()
	
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
				door.close()
				_last_door_closed = door
				_console_writer.success("Door '%s' closed." % id)
			else:
				_console_writer.warn("Door '%s' was already closed." % id)
			return
	_console_writer.error("Door '%s' not found." % id)
	

func _on_Core_on_destroyed() -> void:
	_is_game_over= true
	_console_writer.error("You loose!")
