extends CharacterBody2D

@export var speed = 250
@export var max_health = 1000
@export var max_mana = 100
@export var mana_charge = 12

@export var shoot_cost = 4

var health = max_health
var mana = max_mana/2
var charged_mana = 0

signal player_shoot(position:Vector2)

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta: float) -> void:
	if(mana<100):
		charged_mana += mana_charge * delta
	var charging_mana = ceil(charged_mana)/1
	mana += charging_mana
	mana = min(100, mana)
	charged_mana -= charging_mana

	var horizontal = Input.get_axis("player_left", "player_right")
	if horizontal:
		position.x += horizontal * speed * delta

	var vertical1 = Input.get_axis("player_up", "player_down")
	if vertical1:
		position.y += vertical1 * speed * delta

	position.x = maxf(40,minf(440,position.x))
	position.y = maxf(130, minf(715, position.y))

	if Input.is_action_just_released("player_shoot"):
		if(mana>=shoot_cost):
			player_shoot.emit(position)
			mana -= shoot_cost
