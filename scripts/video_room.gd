extends Node3D

@onready var area_3d: Area3D = $Area3D
@onready var video_stream_player: VideoStreamPlayer = $MeshInstance3D/SubViewport/VideoStreamPlayer
@onready var pivot: Node3D = $Pivot

func _ready() -> void:
	area_3d.connect("body_entered", play_video)

func play_video(body) -> void:
	if body is CharacterBody3D:
		video_stream_player.play()

func video_finished() -> void:
	pivot.open()

func _physics_process(_delta: float) -> void:
	if video_stream_player.get_stream_length() / 8 < video_stream_player.stream_position:
		video_finished()
