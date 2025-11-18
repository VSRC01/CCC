extends Label3D

@onready var area_3d: Area3D = $Area3D

var mouse_hovering : bool = false
var menu

func _ready() -> void:
	area_3d.mouse_entered.connect(mouse_entered)
	area_3d.mouse_exited.connect(mouse_exited)
	menu = get_parent()
	
func mouse_entered() -> void:
	mouse_hovering = true
	
func mouse_exited() -> void:
	mouse_hovering = false
	
func _input(_event: InputEvent) -> void:
	if mouse_hovering and Input.is_action_just_pressed("mouse_left"):
		menu.current_target = 5
		menu.journal_next()
