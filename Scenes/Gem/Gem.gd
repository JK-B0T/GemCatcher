extends Area2D

class_name Gem

signal gem_off_screen

@onready var sprite_2d: Sprite2D = $Sprite2D
@onready var gemSize: float = sprite_2d.get_rect().end.y
const SPEED: float = 200.0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	position.y += SPEED * delta
	
	if position.y > Game.vp_rect.end.y + gemSize:
		gem_off_screen.emit()
		die()
	
func die() -> void:
		set_process(false)
		queue_free()

func _on_area_entered(_area: Area2D) -> void:
	die()
