extends Node

const COW_SCENE = preload("res://cow.tscn")
const SPAWN_PAUSE = 1.0 

@onready var spawn_points: Array = $SpawnPoints.get_children()

var previous_spawn:Marker2D = null

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_spawn_cow()
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _spawn_cow() -> void:
	var choices: Array = spawn_points.filter(func(p): return p != previous_spawn)
	var spot : Marker2D = choices[randi() % choices.size()]
	previous_spawn = spot
	
	
	var cow = COW_SCENE.instantiate()
	cow.global_position = spot.global_position
	add_child(cow)
	cow.tree_exited.connect(_on_cow_gone)
	
func _on_cow_gone() -> void:
	await get_tree().create_timer(SPAWN_PAUSE).timeout
	_spawn_cow()
