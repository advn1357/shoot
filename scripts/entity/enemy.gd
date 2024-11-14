extends Area2D

@export var speed = 130
@export var max_health = 3

var health = max_health

signal reach_bottom(damage:int)
signal on_damage(score:int)
signal on_death(score:int)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$ProgressBar.max_value = max_health

func damage(damage:int):
	on_damage.emit(damage*2)
	health -= damage

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$ProgressBar.value = health
	if (health<=0):
		on_death.emit(max_health*5)
		queue_free()

	position.y += speed * delta
	if(position.y >= 830):
		reach_bottom.emit(1)
		self.queue_free()
