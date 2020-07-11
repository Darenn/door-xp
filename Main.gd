extends Node2D


onready var _console = $GUI/DebugConsole/Console
onready var _console_writer = $GUI/DebugConsole
onready var _doors = $Doors
onready var _viruses = $Viruses

func _ready() -> void:
	# start
	var startRef = CommandRef.new(self, "_start", 0)
	var startCommand = ConsoleCommand.new("start", startRef, "Start the loaded level.")
	_console.add_command(startCommand)
	
	# open_door command
	var openDoorRef = CommandRef.new(self, "_open_door", 1)
	var openDoorCommand = ConsoleCommand.new("open_door", openDoorRef, "Open the given door (id).")
	_console.add_command(openDoorCommand)
	
	# close_door command
	var closeDoorRef = CommandRef.new(self, "_close_door", 1)
	var closeDoorCommand = ConsoleCommand.new("close_door", closeDoorRef, "Close the given door (id).")
	_console.add_command(closeDoorCommand)
	
func _start() -> void:
	for virus in _viruses.get_children():
		virus.set_active(true)
	
func _open_door(id: String) -> void:
	for door in _doors.get_children():
		if door.id == id:
			if not door.is_open:
				door.open()
				_console_writer.success("Door %s open." % id)
			else:
				_console_writer.warn("Door %s was already open." % id)
			return
	_console_writer.error("Door %s not found." % id)
	
func _close_door(id: String) -> void:
	for door in _doors.get_children():
		if door.id == id:
			if door.is_open:
				door.close()
				_console_writer.success("Door %s closed." % id)
			else:
				_console_writer.warn("Door %s was already closed." % id)
			return
	_console_writer.error("Door %s not found." % id)
	
