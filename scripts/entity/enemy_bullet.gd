extends Area2D

signal player_enter(damage:int)

@export var speed = 100

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	#TODO head for Rotation move
	position.y += speed * delta
	if(position.y >= 830):
		self.queue_free()

func _on_body_entered(body:Node2D) -> void:
	if body.is_in_group("player"):
		player_enter.emit(10)
		self.queue_free()
