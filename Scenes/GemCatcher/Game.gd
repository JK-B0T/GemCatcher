extends Node2D

class_name Game

const GEM = preload("uid://cx55krg08ovr1")
const EXPLODE = preload("uid://4jryscbv32nt")
const GEM_HALF_SIZE = 24.0

@onready var spawn_timer: Timer = $SpawnTimer
@onready var score_sound: AudioStreamPlayer2D = $ScoreSound
@onready var sound: AudioStreamPlayer = $Sound
@onready var label: Label = $Label

static var vp_rect: Rect2

var _score: int = 0

func _ready() -> void:
	get_viewport().size_changed.connect(update_vp_rect)
	update_vp_rect()
	spawn_gem()

func update_vp_rect() -> void:
	vp_rect = get_viewport_rect()

func spawn_gem() -> void:
	var new_gem: Gem = GEM.instantiate()
	var x_position: float = randf_range(
		vp_rect.position.x + GEM_HALF_SIZE, 
		vp_rect.end.x - GEM_HALF_SIZE
	)
	new_gem.position = Vector2(x_position, -50.0)
	new_gem.connect("gem_off_screen", _on_gem_off_screen)
	add_child(new_gem)

func stop_all() -> void:
	sound.stop()
	sound.stream = EXPLODE
	sound.play()
	spawn_timer.stop()
	for child in get_children():
		if child is Gem or Paddle: child.set_process(false)
		
func add_score() -> void:
	_score += 1
	label.text = "%03d" % _score

func _on_paddle_area_entered(area: Area2D) -> void:
	if !score_sound.playing:
		add_score()
		score_sound.position = area.position
		score_sound.play()

func _on_gem_off_screen() -> void:
	stop_all()

func _on_timer_timeout() -> void:
	spawn_gem()
