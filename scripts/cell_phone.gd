extends Control

@onready var phone : AspectRatioContainer = $ScreenContainer
@onready var tab_container: VBoxContainer = $TabContainer
@onready var screen: PanelContainer = $ScreenContainer/Frame/MarginContainer/Screen
@onready var screen_container: AspectRatioContainer = $ScreenContainer
@onready var understood: Button = $ScreenContainer/Frame/MarginContainer/Screen/Tutorial/VBoxContainer/Understood
@onready var camera_understood: Button = $ScreenContainer/Frame/MarginContainer/Screen/CameraTuto/VBoxContainer/CameraUnderstood
@onready var camera_button: Button = $ScreenContainer/Frame/MarginContainer/Screen/Menu/GridContainer/CameraButton

enum mode {full, mini, camera}
var current_mode : mode = mode.mini
var player : CharacterBody3D
var phone_full_scale : float = 0.8
var phone_mini_scale : float = 0.15

#██████  ███████  █████  ██████  ██    ██ 
#██   ██ ██      ██   ██ ██   ██  ██  ██  
#██████  █████   ███████ ██   ██   ████   
#██   ██ ██      ██   ██ ██   ██    ██    
#██   ██ ███████ ██   ██ ██████     ██                                                 
func _ready() -> void:
	player = get_parent()
	understood.button_down.connect(clear_tip)
	camera_understood.button_down.connect(clear_tip)
	camera_button.button_down.connect(camera_mode)


#███████ ███    ██  █████  ██████  ██      ███████ 
#██      ████   ██ ██   ██ ██   ██ ██      ██      
#█████   ██ ██  ██ ███████ ██████  ██      █████   
#██      ██  ██ ██ ██   ██ ██   ██ ██      ██      
#███████ ██   ████ ██   ██ ██████  ███████ ███████ 
func enable() -> void:
	self.visible = true


#██████  ██ ███████  █████  ██████  ██      ███████ 
#██   ██ ██ ██      ██   ██ ██   ██ ██      ██      
#██   ██ ██ ███████ ███████ ██████  ██      █████   
#██   ██ ██      ██ ██   ██ ██   ██ ██      ██      
#██████  ██ ███████ ██   ██ ██████  ███████ ███████ 
func disable() -> void:
	self.visible = false


#███████ ██    ██ ██      ██              ███████  ██████ ██████  ███████ ███████ ███    ██ 
#██      ██    ██ ██      ██              ██      ██      ██   ██ ██      ██      ████   ██ 
#█████   ██    ██ ██      ██              ███████ ██      ██████  █████   █████   ██ ██  ██ 
#██      ██    ██ ██      ██                   ██ ██      ██   ██ ██      ██      ██  ██ ██ 
#██       ██████  ███████ ███████ ███████ ███████  ██████ ██   ██ ███████ ███████ ██   ████ 
func full_screen() -> void:
	if notification:
		clear_notification()
		open_notification_page()
	var tween = create_tween()
	tween.tween_property(phone, "scale", Vector2(phone_full_scale,phone_full_scale), 0.3)
	current_mode = mode.full


#███    ███ ██ ███    ██ ██         ███████  ██████ ██████  ███████ ███████ ███    ██ 
#████  ████ ██ ████   ██ ██         ██      ██      ██   ██ ██      ██      ████   ██ 
#██ ████ ██ ██ ██ ██  ██ ██         ███████ ██      ██████  █████   █████   ██ ██  ██ 
#██  ██  ██ ██ ██  ██ ██ ██              ██ ██      ██   ██ ██      ██      ██  ██ ██ 
#██      ██ ██ ██   ████ ██ ███████ ███████  ██████ ██   ██ ███████ ███████ ██   ████ 
func mini_screen() -> void:
	match current_mode:
		mode.full:
			var tween = create_tween()
			tween.tween_property(phone, "scale", Vector2(phone_mini_scale,phone_mini_scale), 0.3)
			current_mode = mode.mini
		mode.mini:
			pass
		mode.camera:
			var tween = create_tween()
			tween.set_parallel()
			tween.tween_property(screen_container, "rotation", deg_to_rad(0), .3)
			tween.tween_property(screen_container, "position", Vector2(1180, -44.855), .3)
			tween.tween_property(screen_container, "scale", Vector2(0.15, 0.15), .3)
			camera.visible = false
			menu.visible = true
			current_mode = mode.mini
			
			
@onready var camera: PanelContainer = $ScreenContainer/Frame/MarginContainer/Camera


 #██████  █████  ███    ███ ███████ ██████   █████          ███    ███  ██████  ██████  ███████ 
#██      ██   ██ ████  ████ ██      ██   ██ ██   ██         ████  ████ ██    ██ ██   ██ ██      
#██      ███████ ██ ████ ██ █████   ██████  ███████         ██ ████ ██ ██    ██ ██   ██ █████   
#██      ██   ██ ██  ██  ██ ██      ██   ██ ██   ██         ██  ██  ██ ██    ██ ██   ██ ██      
 #██████ ██   ██ ██      ██ ███████ ██   ██ ██   ██ ███████ ██      ██  ██████  ██████  ███████ 
func camera_mode() -> void:
	match current_mode:
		mode.full:
			current_mode = mode.camera
			var tween = create_tween()
			tween.set_parallel()
			tween.tween_property(screen_container, "rotation", deg_to_rad(-90), .3)
			tween.tween_property(screen_container, "position", Vector2(1260, -1120), .3)
			tween.tween_property(screen_container, "scale", Vector2(1.945, 1.945), .3)
			menu.visible = false
			camera.visible = true
			player.camera_mode()
		mode.mini:
			pass
		mode.camera:
			pass


@onready var bell: Sprite2D = $ScreenContainer/Frame/MarginContainer/Screen/Bell

var notification : bool = true
enum notification_enum {clear, tutorial, camera_tuto}
var notification_page : notification_enum = notification_enum.tutorial

#███    ██  ██████  ████████ ██ ███████ ██    ██ 
#████   ██ ██    ██    ██    ██ ██       ██  ██  
#██ ██  ██ ██    ██    ██    ██ █████     ████   
#██  ██ ██ ██    ██    ██    ██ ██         ██    
#██   ████  ██████     ██    ██ ██         ██    
func notify() -> void:
	menu.visible = false
	bell.visible = true
	notification = true
	var tween = create_tween()
	for i in 15:
		tween.tween_property(screen_container, "position", Vector2(1180.0 - randf_range(-40, 40), -38.0 + randf_range(-40, 40)), 0.1)
	tween.tween_property(screen_container, "position", Vector2(1180, -38), 0.1)

 #██████ ██      ███████  █████  ██████          ███    ██  ██████  ████████ ██ ███████ ██  ██████  █████  ████████ ██  ██████  ███    ██ 
#██      ██      ██      ██   ██ ██   ██         ████   ██ ██    ██    ██    ██ ██      ██ ██      ██   ██    ██    ██ ██    ██ ████   ██ 
#██      ██      █████   ███████ ██████          ██ ██  ██ ██    ██    ██    ██ █████   ██ ██      ███████    ██    ██ ██    ██ ██ ██  ██ 
#██      ██      ██      ██   ██ ██   ██         ██  ██ ██ ██    ██    ██    ██ ██      ██ ██      ██   ██    ██    ██ ██    ██ ██  ██ ██ 
 #██████ ███████ ███████ ██   ██ ██   ██ ███████ ██   ████  ██████     ██    ██ ██      ██  ██████ ██   ██    ██    ██  ██████  ██   ████ 
func clear_notification() -> void:
	bell.visible = false
	notification = false

@onready var camera_tuto: MarginContainer = $ScreenContainer/Frame/MarginContainer/Screen/CameraTuto
@onready var tutorial: MarginContainer = $ScreenContainer/Frame/MarginContainer/Screen/Tutorial
@onready var menu: MarginContainer = $ScreenContainer/Frame/MarginContainer/Screen/Menu

var camera_tuto_complete : bool = false

 #██████  ██████  ███████ ███    ██         ███    ██  ██████  ████████ ██ ███████ ██  ██████  █████  ████████ ██  ██████  ███    ██         ██████   █████   ██████  ███████ 
#██    ██ ██   ██ ██      ████   ██         ████   ██ ██    ██    ██    ██ ██      ██ ██      ██   ██    ██    ██ ██    ██ ████   ██         ██   ██ ██   ██ ██       ██      
#██    ██ ██████  █████   ██ ██  ██         ██ ██  ██ ██    ██    ██    ██ █████   ██ ██      ███████    ██    ██ ██    ██ ██ ██  ██         ██████  ███████ ██   ███ █████   
#██    ██ ██      ██      ██  ██ ██         ██  ██ ██ ██    ██    ██    ██ ██      ██ ██      ██   ██    ██    ██ ██    ██ ██  ██ ██         ██      ██   ██ ██    ██ ██      
 #██████  ██      ███████ ██   ████ ███████ ██   ████  ██████     ██    ██ ██      ██  ██████ ██   ██    ██    ██  ██████  ██   ████ ███████ ██      ██   ██  ██████  ███████ 
func open_notification_page() -> void:
	match notification_page:
		notification_enum.clear:
			menu.visible = true
		notification_enum.tutorial:
			tutorial.visible = true
		notification_enum.camera_tuto:
			camera_tuto.visible = true


 #██████ ██      ███████  █████  ██████          ████████ ██ ██████  
#██      ██      ██      ██   ██ ██   ██            ██    ██ ██   ██ 
#██      ██      █████   ███████ ██████             ██    ██ ██████  
#██      ██      ██      ██   ██ ██   ██            ██    ██ ██      
 #██████ ███████ ███████ ██   ██ ██   ██ ███████    ██    ██ ██      
func clear_tip() -> void:
	if tutorial.visible:
		tutorial.visible = false
		notification_page = notification_enum.clear
		open_notification_page()
	if camera_tuto.visible:
		camera_tuto.visible= false
		camera_tuto_complete = true
		notification_page = notification_enum.clear
		open_notification_page()


#████████  █████  ██████          ██████   ██████  ███████ ██ ████████ ██  ██████  ███    ██ ███████ ██████  
   #██    ██   ██ ██   ██         ██   ██ ██    ██ ██      ██    ██    ██ ██    ██ ████   ██ ██      ██   ██ 
   #██    ███████ ██████          ██████  ██    ██ ███████ ██    ██    ██ ██    ██ ██ ██  ██ █████   ██████  
   #██    ██   ██ ██   ██         ██      ██    ██      ██ ██    ██    ██ ██    ██ ██  ██ ██ ██      ██   ██ 
   #██    ██   ██ ██████  ███████ ██       ██████  ███████ ██    ██    ██  ██████  ██   ████ ███████ ██   ██ 
func tab_positioner(_delta) -> void:
	match current_mode:
		mode.full:
			pass
		mode.mini:
			pass
