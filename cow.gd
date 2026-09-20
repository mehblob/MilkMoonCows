extends Area2D



# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SpawnSound.play()
	body_entered.connect(_on_body_entered)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _on_body_entered(body: Node2D) -> void:
	print("touched by: ", body.name)
	if body.is_in_group("player"):
		$TouchSound.play()
		hide()
		set_deferred("monitoring", false)
		await $TouchSound.finished
		queue_free()
	else:
		print("failed")
