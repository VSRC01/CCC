extends "res://scripts/jornal_1.gd"

@onready var baixo_area_3d: Area3D = $Baixo/Area3D
@onready var medio_area_3d: Area3D = $Medio/Area3D
@onready var alto_area_3d: Area3D = $Alto/Area3D

@export var world_environment : WorldEnvironment

func _ready() -> void:
	baixo_area_3d.mouse_entered.connect(baixo_mouse_entered)
	medio_area_3d.mouse_entered.connect(medio_mouse_entered)
	alto_area_3d.mouse_entered.connect(alto_mouse_entered)
	baixo_area_3d.mouse_exited.connect(baixo_mouse_exited)
	medio_area_3d.mouse_exited.connect(medio_mouse_exited)
	alto_area_3d.mouse_exited.connect(alto_mouse_exited)
	next_area.mouse_entered.connect(next_mouse_entered)
	next_area.mouse_exited.connect(next_mouse_exited)
	back_area.mouse_entered.connect(back_mouse_entered)
	back_area.mouse_exited.connect(back_mouse_exited)

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("left_mouse"):
		if baixo_mouse_hovering:
			if world_environment:
				world_environment.environment.ssr_enabled = false
				world_environment.environment.ssao_enabled = false
				world_environment.environment.ssil_enabled = false
				world_environment.environment.sdfgi_enabled = false
		if medio_mouse_hovering:
			if world_environment:
				world_environment.environment.ssr_enabled = true
				world_environment.environment.ssao_enabled = true
				world_environment.environment.ssil_enabled = true
				world_environment.environment.sdfgi_enabled = false
		if alto_mouse_hovering:
			if world_environment:
				world_environment.environment.ssr_enabled = true
				world_environment.environment.ssao_enabled = true
				world_environment.environment.ssil_enabled = true
				world_environment.environment.sdfgi_enabled = true
		if next_mouse_hovering:
			get_parent().journal_next()
		if back_mouse_hovering:
			get_parent().journal_back()

var baixo_mouse_hovering : bool

func baixo_mouse_entered():
	baixo_mouse_hovering = true

func baixo_mouse_exited():
	baixo_mouse_hovering = false

var medio_mouse_hovering : bool

func medio_mouse_entered():
	medio_mouse_hovering = true

func medio_mouse_exited():
	medio_mouse_hovering = false

var alto_mouse_hovering : bool

func alto_mouse_entered():
	alto_mouse_hovering = true

func alto_mouse_exited():
	alto_mouse_hovering = false
