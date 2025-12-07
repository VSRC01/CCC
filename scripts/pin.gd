extends Node2D

@onready var groove: Sprite2D = $Groove
@onready var spring: Sprite2D = $Spring
@onready var purple_pin: Sprite2D = $PurplePin
@onready var marker_2d: Marker2D = $Marker2D
@onready var area_2d: Area2D = $PurplePin/Area2D

var locked : bool = false

var pin_initial_position : float
var pin_target_position : float
var pin_current_position : float
var pin_velocity : float = 0.1

func _ready() -> void:
	pin_initial_position = purple_pin.position.y
	pin_current_position = pin_initial_position
	pin_target_position = pin_initial_position

func _physics_process(_delta: float) -> void:
	if pin_target_position != pin_current_position:
		pin_current_position = lerp(pin_current_position, pin_target_position, pin_velocity)
		purple_pin.position.y = pin_current_position
	spring.scale.y = 1 * (pin_current_position / pin_initial_position)
