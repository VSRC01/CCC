extends Node3D

@onready var Camera := $Camera3D
@onready var Target1 := $Target1
@onready var Target2 := $Target2
@onready var Target3 := $Target3
@onready var Target4 := $Target4
@onready var Target5 := $Target5
@onready var Target6 := $Target6
@onready var Player := $"../Player"

var current_target : int
var tween_time = 1
var tween_time_cinematic = 2

func _ready() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(Camera, "position", Target1.position, tween_time_cinematic)
	tween.tween_property(Camera, "rotation", Target1.rotation, tween_time_cinematic)
	current_target = 1
	
func to_journal() -> void:
	var tween = create_tween()
	tween.set_parallel(true)
	tween.tween_property(Camera, "position", Target2.position, tween_time)
	tween.tween_property(Camera, "rotation", Target2.rotation, tween_time)
	await tween.finished
	current_target = 2

func journal_next() -> void:
	match current_target:
		1:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(Camera, "position", Target2.position, tween_time)
			tween.tween_property(Camera, "rotation", Target2.rotation, tween_time)
			await tween.finished
			current_target = 2
	
		2:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(Camera, "position", Target3.position, tween_time)
			tween.tween_property(Camera, "rotation", Target3.rotation, tween_time)
			await tween.finished
			current_target = 3
		3:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(Camera, "position", Target4.position, tween_time)
			tween.tween_property(Camera, "rotation", Target4.rotation, tween_time)
			await  tween.finished
			current_target = 4
		4:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(Camera, "position", Target5.position, tween_time)
			tween.tween_property(Camera, "rotation", Target5.rotation, tween_time)
			await tween.finished
			current_target = 5
		5:
			var tween = create_tween()
			tween.set_parallel(true)
			tween.tween_property(Camera, "position", Target6.position, tween_time_cinematic)
			tween.tween_property(Camera, "rotation", Target6.rotation, tween_time_cinematic)
			await tween.finished
			current_target = 6
			self.visible = false
			Camera.reparent(Player)
			Player.Camera = Camera
			Player.possess()
			
	
func journal_back() -> void:
	pass
