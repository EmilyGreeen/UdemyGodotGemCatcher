extends Node2D

const EXPLODE = preload("res://assets/explode.wav")

@export var gem_scene: PackedScene
@onready var score_label: Label = $Label
@onready var gameover: Label = $GAMEOVER
@onready var timer: Timer = $Timer
@onready var bgm: AudioStreamPlayer = $BGM
@onready var sfx: AudioStreamPlayer2D = $SFX

var _score: int = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func spawn_gem() -> void:
	var new_gem: Gem = gem_scene.instantiate()
	
	new_gem.position.x = randi_range(0,get_viewport_rect().size.x)
	new_gem.position.y = -50
	new_gem.speed *= randf_range(0.75,1.75)
	
	new_gem.on_gem_off_screen.connect(game_over)
	
	add_child(new_gem)


func stop_all() -> void:
	timer.stop()
	for child in get_children():
		child.set_process(false)

func play_dead() -> void:
	sfx.stop()
	bgm.stop()
	sfx.stream = EXPLODE
	sfx.play()
	
func showGameOverLabel() -> void:
	gameover.visible_characters = -1

func game_over() -> void:
	stop_all()
	play_dead()
	showGameOverLabel()


func _on_timer_timeout() -> void:
	print("TIME!!")
	spawn_gem()


func _on_paddle_area_entered(area: Area2D) -> void:
	_score += 10
	score_label.text = "%05d" %_score
	sfx.position = area.position
	sfx.pitch_scale += randf_range(0, 0.25)
	sfx.play()
	area.queue_free()
