class_name PlayerMoving
extends State

@onready var player: Player = $"../.."
@onready var playerBody: CharacterBody2D = $"../../PlayerCharacterBody"

@export var maxspeed: int
@export var acceleration: float
@export var rotationSpeed: float
@export var rotationTargetRadians: float

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

func enter() -> void:
	pass
	
func exit() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func update(_delta: float) -> void:
	pass
	
func physics_update(delta: float) -> void:
	var currentDirection: Vector2
	var currentRotation: float
	var targetRotation: float
	
	if !Input.is_anything_pressed():
		if !Input.is_action_pressed("UP") and !Input.is_action_pressed("LEFT") and !Input.is_action_pressed("RIGHT") and !Input.is_action_pressed("DOWN"):
			transitioned.emit(self, "playeridle")
			return
	
	currentDirection = Vector2.UP.rotated(playerBody.rotation)
	currentRotation = playerBody.rotation
	targetRotation = currentRotation
	
	if Input.is_action_pressed("UP"):
		playerBody.velocity = playerBody.velocity.move_toward(currentDirection * maxspeed, delta * acceleration)
	if Input.is_action_pressed("DOWN"):
		playerBody.velocity = playerBody.velocity.move_toward(-1 * currentDirection * maxspeed, delta * acceleration)
	if Input.is_action_pressed("LEFT"):
		targetRotation = playerBody.rotation - rotationTargetRadians		
	if Input.is_action_pressed("RIGHT"):
		targetRotation = playerBody.rotation + rotationTargetRadians
	
	playerBody.rotation = lerp_angle(playerBody.rotation, targetRotation, rotationSpeed * delta)
		
		

		
