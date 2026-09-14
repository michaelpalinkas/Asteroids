class_name  MainGame
extends Node

const LVL1_UID: String = "uid://bk7vltyxhqtfr"
const PLAYER_UID: String = "uid://cy7nbtrv0510p"
const ASTEROID_UID: String = "uid://cwwtqa88c4cic"

var player: Player = null
var _current_level: BaseLevel = null

#game world root nodes
@onready var level_root = %LevelRoot
@onready var entity_root = %EntityRoot
@onready var effects_root = %EffectsRoot

#ui root nodes
@onready var hud_root = %HudRoot
@onready var pause_root = %PauseRoot
@onready var transtition_root = %TransitionRoot
@onready var debug_root = %DebugRoot

signal edge

# Called when the node enters the scene tree for the first time.
func _ready():
	_init_player()
	load_level(LVL1_UID)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _perform_level_load(level_scene_uid: String) -> void:
	var new_level_packed: PackedScene
	var new_level: Node
	
	if is_instance_valid(_current_level):
		_current_level.queue_free()
		_current_level = null
		await get_tree().process_frame
	
	new_level_packed = ResourceLoader.load(level_scene_uid) as PackedScene
	new_level = new_level_packed.instantiate()
	
	_current_level = new_level as BaseLevel
	
	level_root.add_child(_current_level)
	_place_player_at_level_spawn()
	_connect_signals()
	player.addMainGameRef(self)
	_spawn_starting_asteroids()

func _connect_signals():
	_current_level.leftEdge.connect(_leftEdge)
	_current_level.rightEdge.connect(_rightEdge)
	_current_level.topEdge.connect(_topEdge)
	_current_level.bottomEdge.connect(_bottomEdge)
	
func _spawn_starting_asteroids():
	for i in _current_level.get_starting_asteroid_count():
		_spawn_asteroid()
		
func _spawn_asteroid():
	var asteroid_scene: PackedScene = ResourceLoader.load(ASTEROID_UID) as PackedScene
	var asteroid_instance: Node = asteroid_scene.instantiate()
	
	asteroid_instance.set_asteroid_min_max_speed(_current_level.get_max_asteroid_speed(), _current_level.get_min_asteroid_speed())
	entity_root.add_child(asteroid_instance as Asteroid)
	asteroid_instance.global_position = asteroid_instance.get_random_asteriod_spawn()

func _init_player() -> void:
	var player_scene: PackedScene = ResourceLoader.load(PLAYER_UID) as PackedScene
	var player_instance: Node = player_scene.instantiate()
	
	player = player_instance as Player
	
	entity_root.add_child(player)
	
func _place_player_at_level_spawn() -> void:
	player.global_position = _current_level.get_default_player_spawn()
	
func load_level(level_scene: String) -> void:
	_perform_level_load.call_deferred(level_scene)

func _leftEdge(body: Node2D) -> void:
	_processEdge(body, "LEFT")
	
func _rightEdge(body: Node2D) -> void:
	_processEdge(body, "RIGHT")

func _topEdge(body: Node2D) -> void:
	_processEdge(body, "TOP")
	
func _bottomEdge(body: Node2D) -> void:
	_processEdge(body, "BOTTOM")

func _processEdge(body: Node2D, direction: String):
	match body.name:
		"PlayerCharacterBody":
			edge.emit(direction)
	
	
	
