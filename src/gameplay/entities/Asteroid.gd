class_name Asteroid
extends Node2D

@onready var asteroid_body: CharacterBody2D = $AsteroidBody

@export var asteroidEdgeBuffer: int

var maxAsteroidSpeed: int
var minAsteroidSpeed: int

func set_asteroid_min_max_speed(maxSpeed: int, minSpeed: int):
	maxAsteroidSpeed = maxSpeed
	minAsteroidSpeed = minSpeed

func get_random_asteriod_spawn() -> Vector2:
	var spawnPos: Vector2
	var randInt: int 
	
	randInt = randi_range(0, 4)
	if randInt < 1: #from left screen
		spawnPos.x = -asteroidEdgeBuffer
		spawnPos.y = randi_range(0, 1024)
		asteroid_body.velocity = Vector2(randi_range(minAsteroidSpeed, maxAsteroidSpeed), randi_range(-maxAsteroidSpeed, maxAsteroidSpeed))
	elif randInt < 2: #from right screen
		spawnPos.x = get_viewport_rect().size.x + asteroidEdgeBuffer
		spawnPos.y = randi_range(0, 1024)
		asteroid_body.velocity = Vector2(randi_range(-maxAsteroidSpeed, minAsteroidSpeed), randi_range(-maxAsteroidSpeed, maxAsteroidSpeed))
	elif randInt < 3: #from top screen
		spawnPos.x = randi_range(0, 1024)
		spawnPos.y = -asteroidEdgeBuffer
		asteroid_body.velocity = Vector2(randi_range(-maxAsteroidSpeed, maxAsteroidSpeed), randi_range(minAsteroidSpeed, maxAsteroidSpeed))
	else: #from bottom screen
		spawnPos.x = randi_range(0, 1024)
		spawnPos.y = get_viewport_rect().size.y + asteroidEdgeBuffer
		asteroid_body.velocity = Vector2(randi_range(-maxAsteroidSpeed, maxAsteroidSpeed), randi_range(-maxAsteroidSpeed, minAsteroidSpeed))
	
	return spawnPos
	
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _physics_process(delta: float) -> void:
	asteroid_body.move_and_slide()
