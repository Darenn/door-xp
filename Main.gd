extends Node2D


onready var _console = $GUI/DebugConsole/Console
onready var _console_writer = $GUI/DebugConsole
onready var _doors = $Doors

func _ready() -> void:
	var openDoorRef = CommandRef.new(self, "_open_door", 1)
	var openDoorCommand = ConsoleCommand.new("open_door", openDoorRef, "Open the given door (id)")
	_console.add_command(openDoorCommand)
	
func _open_door(id: String) -> void:
	for door in _doors.get_children():
		if door.id == id:
			door.activate()
			_console_writer.success("Door %s open." % id)
			return
	_console_writer.error("Door %s not found." % id)
	
