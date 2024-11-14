extends Node2D

@export var castle_health = 10
var score = 0
var time = 0

const player_bullet_scene : PackedScene = preload("res://sceens/entity/PlayerBullet.tscn")
const enemy_scene : PackedScene = preload("res://sceens/entity/enemy.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	# score += 1
	time += delta

	if(randf()<=0.55*delta):
		var enemy_instance : Area2D = enemy_scene.instantiate()
		add_child(enemy_instance)
		enemy_instance.position = Vector2(randi_range(50,430),-40)
		enemy_instance.scale = Vector2(0.25, 0.25)
		enemy_instance.reach_bottom.connect(_on_enemy_reach_bottom)
		enemy_instance.on_damage.connect(_on_enemy_on_damage)
		enemy_instance.on_death.connect(_on_enemy_on_death)

func _player_damage(damage:int):
	$Player.health -= damage
	score -= damage * 50

func _castle_damage(damage:int):
	castle_health -= damage
	score -= damage * 500

func _on_bullet_player_enter(damage:int) -> void:
	_player_damage(damage)

func _on_enemy_reach_bottom(damage:int) -> void:
	_castle_damage(damage)

func _on_player_player_shoot(_position:Vector2) -> void:
	score -= 1
	var player_bullet_instance : Area2D = player_bullet_scene.instantiate()
	add_child(player_bullet_instance)
	player_bullet_instance.scale = Vector2(0.5, 0.5)
	player_bullet_instance.position = _position

func _on_enemy_on_death(_score:int) -> void:
	score += _score

func _on_enemy_on_damage(_score:int) -> void:
	score += _score
	$Player.charged_mana += _score/2
