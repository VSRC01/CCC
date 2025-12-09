extends Node2D

@onready var lockpick: Node2D = $Lockpick
@onready var gira_giras: Node2D = $GiraGiras
@onready var first_pin: Node2D = $FirstPin
@onready var second_pin: Node2D = $SecondPin
@onready var third_pin: Node2D = $ThirdPin
@onready var fourth_pin: Node2D = $FourthPin
@onready var lock: Node2D = $Lock

@onready var lockpick_assets_2: Sprite2D = $Lock/LockpickAssets3/LockpickAssets2

var lockpick_position : int = 1

@onready var marker_2d: Marker2D = $Lock/Marker2D

func _ready() -> void:
	var tween = create_tween()
	tween.tween_property(lockpick, "position:y", first_pin.marker_2d.global_position.y, 0.3)
	tween.tween_property(lockpick, "position:x", first_pin.marker_2d.global_position.x, 0.6)
	tween.tween_property(gira_giras, "position", marker_2d.position, 0.3)
	await tween.finished
	gira_giras.reparent(lockpick_assets_2)
	
	
func _input(_event: InputEvent) -> void:
	if Input.is_action_just_pressed("a"):
		if lockpick_position > 1:
			lockpick_position -= 1
			lockpick_positioner()
	if Input.is_action_just_pressed("d"):
		if lockpick_position < 4:
			lockpick_position += 1
			lockpick_positioner()
	if Input.is_action_just_pressed("space"):
		if not locked:
			match lockpick_position:
				1:
					lockpick_pick(first_pin)
				2:
					lockpick_pick(second_pin)
				3:
					lockpick_pick(third_pin)
				4:
					lockpick_pick(fourth_pin)
		if locked:
			match lockpick_position:
				1:
					if not first_pin.locked:
						try_lock(first_pin)
				2:
					if not second_pin.locked:
						try_lock(second_pin)
				3:
					if not third_pin.locked:
						try_lock(third_pin)
				4:
					if not fourth_pin.locked:
						try_lock(fourth_pin)

var positioner_speed : float = 0.3

func lockpick_positioner() -> void:
	var tween = create_tween()
	match lockpick_position:
		1:
			tween.tween_property(lockpick, "position:x", first_pin.marker_2d.global_position.x, positioner_speed)
		2:
			tween.tween_property(lockpick, "position:x", second_pin.marker_2d.global_position.x, positioner_speed)
		3:
			tween.tween_property(lockpick, "position:x", third_pin.marker_2d.global_position.x, positioner_speed)
		4:
			tween.tween_property(lockpick, "position:x", fourth_pin.marker_2d.global_position.x, positioner_speed)

var locked : bool = false

func lockpick_pick(pin) -> void:
	if not locked:
		locked = true
		var lockpick_tween = create_tween()
		lockpick_tween.tween_property(lockpick, "position:y", lockpick.position.y + 60, 0.1)
		if not pin.locked:
			pin.pin_target_position = 0
		lockpick_tween.tween_property(lockpick, "position:y", lockpick.position.y, 0.1)
		await lockpick_tween.finished
		if not pin.locked:
			pin.pin_target_position = pin.pin_initial_position
		locked = false
		
@onready var lock_area_2d: Area2D = $Lock/Area2D

func try_lock(pin) -> void:
	var areas = lock_area_2d.get_overlapping_areas()
	for area in areas:
		if area == pin.area_2d:
			pin.locked = true
			locked_pin_amount += 1
			pin.pin_target_position = pin.pin_current_position
	areas = null
	check_all()
	
var locked_pin_amount : int = 0
var completed : bool = false

func check_all():
	if locked_pin_amount == 4:
		var tween = create_tween()
		tween.tween_property(lockpick_assets_2, "rotation", deg_to_rad(90), 0.5)
		await tween.finished
		self.get_parent().open()
		completed = true
		find_parent("Main").player.cell_phone.visible = true
		find_parent("Main").player.paused = false
		self.queue_free()
		
