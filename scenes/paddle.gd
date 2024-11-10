extends Area2D

class_name Paddle

@export var speed: float = 1000.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.x += speed * delta * Input.get_axis("left","right")
	
	if position.x > get_viewport_rect().size.x:
		position.x = 0
	if position.x < 0:
		position.x = get_viewport_rect().size.x
