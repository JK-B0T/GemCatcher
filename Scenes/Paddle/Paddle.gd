extends Area2D

class_name Paddle

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var paddle_size: float = sprite_2d.get_rect().end.x
const SPEED: float = 360.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	var direction = Input.get_axis("move_left", "move_right")
	position.x += SPEED * direction * delta
		
	position.x = clampf(
		position.x,
		Game.vp_rect.position.x + paddle_size, 
		Game.vp_rect.end.x - paddle_size
	)

func _on_area_entered(_area: Area2D) -> void:
	print("Paddle eating good lads")
