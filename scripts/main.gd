extends Node3D

@onready var player: CharacterBody3D = $Player
@onready var world_environment: WorldEnvironment = $WorldEnvironment

var graphics : graphics_presets
enum graphics_presets {low, medium, high}

func change_graphics_preset(new_preset : graphics_presets) -> void:
	match new_preset:
		graphics_presets.low:
			graphics = graphics_presets.low
			if world_environment:
				world_environment.environment.ssr_enabled = false
				world_environment.environment.ssao_enabled = false
				world_environment.environment.ssil_enabled = false
				world_environment.environment.sdfgi_enabled = false
		graphics_presets.medium:
			graphics = graphics_presets.medium
			if world_environment:
				world_environment.environment.ssr_enabled = true
				world_environment.environment.ssao_enabled = true
				world_environment.environment.ssil_enabled = true
				world_environment.environment.sdfgi_enabled = false
		graphics_presets.high:
			graphics = graphics_presets.high
			if world_environment:
				world_environment.environment.ssr_enabled = true
				world_environment.environment.ssao_enabled = true
				world_environment.environment.ssil_enabled = true
				world_environment.environment.sdfgi_enabled = true
