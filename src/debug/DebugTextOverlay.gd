extends Control

const VERSION: String = "application/config/version"

@onready var fps_label: Label = $MarginContainer/VBoxContainer/FpsLabel
@onready var version_info: Label = $MarginContainer/VBoxContainer/VersionInfo


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_add_version_to_label()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	fps_label.set_text("FPS: " + str(Engine.get_frames_per_second()))
	
func _add_version_to_label() -> void:
	var version_str: String = ProjectSettings.get_setting(VERSION)
	version_info.text = version_str
