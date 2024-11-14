extends Area2D

@export var speed = 250
@export var damage = 1

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y -= speed * delta

	if(position.y<=-20):
		queue_free()

func _on_area_entered(area:Area2D) -> void:
	if(area.is_in_group("enemy")):
		area.damage(damage)
		queue_free()
