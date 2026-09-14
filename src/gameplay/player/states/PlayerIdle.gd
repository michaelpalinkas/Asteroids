class_name	PlayerIdle 
extends State

@onready var player: Player = $"../.."
@onready var playerBody: CharacterBody2D = $"../../PlayerCharacterBody"

@export var friction: float

const STOPPED_VECTOR: Vector2 = Vector2(0, 0)

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
	if Input.is_anything_pressed():
		transitioned.emit(self, "playermoving")
		return
	
	playerBody.velocity = playerBody.velocity.move_toward(STOPPED_VECTOR, delta * friction)
