extends MeshInstance3D

@onready var next_area := $Next/Area3D
@onready var back_area := $Back/Area3D

var next_mouse_hovering = false
var back_mouse_hovering = false


func _ready() -> void:
	next_area.mouse_entered.connect(next_mouse_entered)
	next_area.mouse_exited.connect(next_mouse_exited)
	back_area.mouse_entered.connect(back_mouse_entered)
	back_area.mouse_exited.connect(back_mouse_exited)

func next_mouse_entered():
	next_mouse_hovering = true

func next_mouse_exited():
	next_mouse_hovering = false

func back_mouse_entered():
	back_mouse_hovering = true

func back_mouse_exited():
	back_mouse_hovering = false

func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("mouse_left"):
		if next_mouse_hovering:
			get_parent().journal_next()
		elif back_mouse_hovering:
			get_parent().journal_back()
