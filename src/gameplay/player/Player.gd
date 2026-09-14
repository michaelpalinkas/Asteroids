class_name Player 
extends Node2D

@onready var playerBody: CharacterBody2D = $PlayerCharacterBody
@onready var playerCollisionPolygon: CollisionPolygon2D = $PlayerCharacterBody/PlayerCollisionPolygon

const EDGEBUFFER: int = 2

var mainGame: MainGame
var processingEdge: bool 
var edgeDirection: String

func addMainGameRef(main: MainGame) -> void:
	mainGame = main
	mainGame.edge.connect(_edge)
	processingEdge = false

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _physics_process(delta: float) -> void:
	playerBody.move_and_slide()

	if processingEdge == true:
		match edgeDirection:
			"LEFT":
				playerBody.global_position.x = get_viewport_rect().size.x + EDGEBUFFER
				processingEdge = false
				edgeDirection = ""
			"RIGHT":
				playerBody.global_position.x = 0 - EDGEBUFFER
				processingEdge = false
				edgeDirection = ""
			"TOP":
				playerBody.global_position.y = get_viewport_rect().size.y + EDGEBUFFER
				processingEdge = false
				edgeDirection = ""
			"BOTTOM":
				playerBody.global_position.y = 0 - EDGEBUFFER	
				processingEdge = false
				edgeDirection = ""
	
func _edge(direction: String) -> void:
	if processingEdge == false:
		processingEdge = true	
		edgeDirection = direction
