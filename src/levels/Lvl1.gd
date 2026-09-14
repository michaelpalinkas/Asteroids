extends BaseLevel

@onready var player_spawn: Marker2D = $PlayerSpawn
@onready var left_world_border: Area2D = $LeftWorldBorder
@onready var collision_shape_2d: CollisionShape2D = $LeftWorldBorder/CollisionShape2D

@export var maxAsteroidCount: int
@export var startingAsteroidCount: int
@export var maxAsteroidSpeed: int
@export var minAsteroidSpeed: int

signal leftEdge
signal rightEdge
signal topEdge
signal bottomEdge

var asteroidCount

func get_default_player_spawn() -> Vector2:
	return player_spawn.position

func get_max_asteroid_count() -> int:
	return maxAsteroidCount
	
func get_starting_asteroid_count() -> int:
	return startingAsteroidCount

func get_max_asteroid_speed() -> int:
	return maxAsteroidSpeed
	
func get_min_asteroid_speed() -> int:
	return minAsteroidSpeed
	
# Called when the node enters the scene tree for the first time.
func _ready():
	player_spawn.position.x = get_viewport_rect().size.x / 2
	player_spawn.position.y = get_viewport_rect().size.y / 2
	
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	pass

func _on_left_world_border_body_entered(body: Node2D) -> void:
	leftEdge.emit(body)

func _on_right_world_border_body_entered(body: Node2D) -> void:
	rightEdge.emit(body)

func _on_top_world_border_body_entered(body: Node2D) -> void:
	topEdge.emit(body)

func _on_bottom_world_border_body_entered(body: Node2D) -> void:
	bottomEdge.emit(body)
