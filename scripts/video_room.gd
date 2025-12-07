extends Node3D

@onready var area_3d: Area3D = $Area3D
@onready var video_stream_player: VideoStreamPlayer = $MeshInstance3D/SubViewport/VideoStreamPlayer

func _ready() -> void:
	area_3d.connect("body_entered", play_video)
	
func play_video(body) -> void:
	if body is CharacterBody3D:
		video_stream_player.play()
