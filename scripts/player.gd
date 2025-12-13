extends CharacterBody3D

@onready var cell_phone: Control = $CellPhone

var Camera : Camera3D
var possessed : bool = false
var paused : bool = false
var mouse_sense : float = 0.003
var input_dir : Vector2
var speed : float = 4
var movement_velocity : Vector3 
var acceleration = 0.6


		#██████  ███████  █████  ██████  ██    ██ 
		#██   ██ ██      ██   ██ ██   ██  ██  ██  
		#██████  █████   ███████ ██   ██   ████   
		#██   ██ ██      ██   ██ ██   ██    ██    
#███████ ██   ██ ███████ ██   ██ ██████     ██    	  
func _ready() -> void:
	cell_phone.disable()


#██████   ██████  ███████ ███████ ███████ ███████ ███████ 
#██   ██ ██    ██ ██      ██      ██      ██      ██      
#██████  ██    ██ ███████ ███████ █████   ███████ ███████ 
#██      ██    ██      ██      ██ ██           ██      ██ 
#██       ██████  ███████ ███████ ███████ ███████ ███████ 
func possess() -> void:
	possessed = true
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	cell_phone.enable()
	cell_phone.notify()
	if Camera:
		ray_cast_3d.reparent(Camera)


		#██    ██ ███    ██ ██   ██  █████  ███    ██ ██████  ██      ███████ ██████          ██ ███    ██ ██████  ██    ██ ████████ 
		#██    ██ ████   ██ ██   ██ ██   ██ ████   ██ ██   ██ ██      ██      ██   ██         ██ ████   ██ ██   ██ ██    ██    ██    
		#██    ██ ██ ██  ██ ███████ ███████ ██ ██  ██ ██   ██ ██      █████   ██   ██         ██ ██ ██  ██ ██████  ██    ██    ██    
		#██    ██ ██  ██ ██ ██   ██ ██   ██ ██  ██ ██ ██   ██ ██      ██      ██   ██         ██ ██  ██ ██ ██      ██    ██    ██    
#███████  ██████  ██   ████ ██   ██ ██   ██ ██   ████ ██████  ███████ ███████ ██████  ███████ ██ ██   ████ ██       ██████     ██    
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and possessed and not paused:
		Camera.rotation.x += -event.screen_relative.y * mouse_sense
		self.rotation.y += -event.screen_relative.x * mouse_sense


		#██ ███    ██ ██████  ██    ██ ████████ 
		#██ ████   ██ ██   ██ ██    ██    ██    
		#██ ██ ██  ██ ██████  ██    ██    ██    
		#██ ██  ██ ██ ██      ██    ██    ██    
#███████ ██ ██   ████ ██       ██████     ██        
@onready var ray_cast_3d: RayCast3D = $RayCast3D

var is_holding_bell : bool = false
var is_holding_pannel : bool = false
var is_holding_model : bool = false
var hold_pannel
var hold_model
var hold_bell
var ray_parent

@onready var left_mouse: Sprite2D = $LeftMouse
@onready var crosshair: Sprite2D = $Crosshair

var lockpick_minigame = preload("res://scenes/lockpick_minigame.tscn")
	  
func _input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion and possessed and not paused and is_camera_mode:
		Camera.rotation.x += -_event.screen_relative.y * mouse_sense
		self.rotation.y += -_event.screen_relative.x * mouse_sense
	if possessed:
		if Input.is_action_just_pressed("mouse_wheel_up") and is_holding_model:
			hold_model.rotation.x += .1
		if Input.is_action_just_pressed("mouse_wheel_down") and is_holding_model:
			hold_model.rotation.x -= .1
		if Input.is_action_just_pressed("esc"):
			#███████ ███████  ██████ 
			#██      ██      ██      
			#█████   ███████ ██      
			#██           ██ ██      
			#███████ ███████  ██████ 
			if paused and not is_camera_mode:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
				paused = false
				cell_phone.mini_screen()
			if not paused:
				pass
			if is_camera_mode:
				cell_phone.mini_screen()
				is_camera_mode = false
		if Input.is_action_just_pressed("tab"):
			#████████  █████  ██████      
			   #██    ██   ██ ██   ██     
			   #██    ███████ ██████      
			   #██    ██   ██ ██   ██     
			   #██    ██   ██ ██████      
			if not paused and not is_camera_mode:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
				paused = true
				cell_phone.full_screen()
			if is_camera_mode:
				cell_phone.mini_screen()
				is_camera_mode = false
		if Input.is_action_just_pressed("c"):
			 #██████ 
			#██      
			#██      
			#██      
			 #██████ 
			 # open camera 
			pass                                                             
		if Input.is_action_just_pressed("left_mouse"):
			#██      ███████ ███████ ████████         ███    ███  ██████  ██    ██ ███████ ███████ 
			#██      ██      ██         ██            ████  ████ ██    ██ ██    ██ ██      ██      
			#██      █████   █████      ██            ██ ████ ██ ██    ██ ██    ██ ███████ █████   
			#██      ██      ██         ██            ██  ██  ██ ██    ██ ██    ██      ██ ██      
			#███████ ███████ ██         ██    ███████ ██      ██  ██████   ██████  ███████ ███████   
			if is_holding_bell:
				hold_bell.reparent(ray_parent)
				is_holding_bell = false
				hold_bell.freeze = false
				hold_bell = null
				return
			if is_holding_pannel:
				hold_pannel.reparent(ray_parent)
				is_holding_pannel = false	
				hold_pannel.freeze = false
				hold_pannel = null
				return
			if is_holding_model:
				hold_model.reparent(ray_parent)
				is_holding_model = false
				hold_model.freeze = false
				hold_model = null
				return
			if not is_camera_mode and not is_holding_pannel and not is_holding_model and not is_holding_bell and not paused:
				var ray_collider = ray_cast_3d.get_collider()
				if ray_collider is StaticBody3D:
					if ray_collider.find_parent("CellDoor"):
						paused = true
						var lockpick_node = lockpick_minigame.instantiate()
						ray_collider.find_parent("CellDoor").add_child(lockpick_node)
						cell_phone.visible = false
						left_mouse.visible = false
						crosshair.visible = false
				if ray_collider is RigidBody3D:
					if ray_collider.get_parent().name == "BellRoom":
						ray_parent = ray_collider.get_parent()
						hold_bell = ray_collider
						hold_bell.reparent(Camera)
						hold_bell.freeze = true
						var tween = create_tween()
						tween.set_parallel()
						tween.tween_property(hold_bell, "position", Vector3(0,0,-2), .5)
						tween.tween_property(hold_bell, "rotation", Vector3(deg_to_rad(0), deg_to_rad(0), deg_to_rad(0)), .5)
						is_holding_bell = true
					if ray_collider.get_parent().name == "Maquete":
						ray_parent = ray_collider.get_parent()
						hold_model = ray_collider
						hold_model.reparent(Camera)
						hold_model.freeze = true
						var tween = create_tween()
						tween.set_parallel()
						tween.tween_property(hold_model, "position", Vector3(0,0,-2), .5)
						tween.tween_property(hold_model, "rotation", Vector3(deg_to_rad(0), deg_to_rad(0), deg_to_rad(0)), .5)
						is_holding_model = true
						return
					if ray_collider.get_parent().name == "SjPannels3D":
						ray_parent = ray_collider.get_parent()
						hold_pannel = ray_collider
						hold_pannel.reparent(Camera)
						if hold_pannel.get_parent().name == Camera.name:
							hold_pannel.freeze = true
							var tween = create_tween()
							tween.set_parallel()
							tween.tween_property(hold_pannel, "position", Vector3(0,0,-2), .5)
							tween.tween_property(hold_pannel, "rotation", Vector3(deg_to_rad(0), deg_to_rad(-90), deg_to_rad(0)), .5)
							is_holding_pannel = true
							return		
			if is_camera_mode:
				cell_phone.take_photo()
				var ray_collider = ray_cast_3d.get_collider()
				if ray_collider is Area3D:
					var ray_collider_parent = ray_collider.get_parent_node_3d()
					if ray_collider_parent.name == "QrCode":
						ray_collider_parent = ray_collider_parent.get_parent_node_3d()
						if not ray_collider_parent.is_open:
							ray_collider_parent.open()
							
							
func drop_pannel() -> void:
	if is_holding_pannel:
		is_holding_pannel = false	
		hold_pannel.freeze = false
		hold_pannel = null
		return
				
	
				
 #██████  █████  ███    ███ ███████ ██████   █████          ██████   ██████  ███████ ██ ████████ ██  ██████  ███    ██ ███████ ██████  
#██      ██   ██ ████  ████ ██      ██   ██ ██   ██         ██   ██ ██    ██ ██      ██    ██    ██ ██    ██ ████   ██ ██      ██   ██ 
#██      ███████ ██ ████ ██ █████   ██████  ███████         ██████  ██    ██ ███████ ██    ██    ██ ██    ██ ██ ██  ██ █████   ██████  
#██      ██   ██ ██  ██  ██ ██      ██   ██ ██   ██         ██      ██    ██      ██ ██    ██    ██ ██    ██ ██  ██ ██ ██      ██   ██ 
 #██████ ██   ██ ██      ██ ███████ ██   ██ ██   ██ ███████ ██       ██████  ███████ ██    ██    ██  ██████  ██   ████ ███████ ██   ██                                                                                                                                     		
@onready var camera_3d: Camera3D = $CellPhone/ScreenContainer/Frame/MarginContainer/Camera/SubViewportContainer/SubViewport/Camera3D

func camera_positioner() -> void:
	if possessed and Camera != null:
		camera_3d.position = Camera.global_position
		camera_3d.rotation = Camera.global_rotation + Vector3(0,0,deg_to_rad(90))


 #██████  █████  ███    ███ ███████ ██████   █████          ███    ███  ██████  ██████  ███████ 
#██      ██   ██ ████  ████ ██      ██   ██ ██   ██         ████  ████ ██    ██ ██   ██ ██      
#██      ███████ ██ ████ ██ █████   ██████  ███████         ██ ████ ██ ██    ██ ██   ██ █████   
#██      ██   ██ ██  ██  ██ ██      ██   ██ ██   ██         ██  ██  ██ ██    ██ ██   ██ ██      
 #██████ ██   ██ ██      ██ ███████ ██   ██ ██   ██ ███████ ██      ██  ██████  ██████  ███████ 
var is_camera_mode : bool = false

func camera_mode() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	is_camera_mode = true
	paused = false


		#██████  ██   ██ ██    ██ ███████ ██  ██████ ███████         ██████  ██████   ██████   ██████ ███████ ███████ ███████ 
		#██   ██ ██   ██  ██  ██  ██      ██ ██      ██              ██   ██ ██   ██ ██    ██ ██      ██      ██      ██      
		#██████  ███████   ████   ███████ ██ ██      ███████         ██████  ██████  ██    ██ ██      █████   ███████ ███████ 
		#██      ██   ██    ██         ██ ██ ██           ██         ██      ██   ██ ██    ██ ██      ██           ██      ██ 
#███████ ██      ██   ██    ██    ███████ ██  ██████ ███████ ███████ ██      ██   ██  ██████   ██████ ███████ ███████ ███████ 
func _physics_process(delta: float) -> void:
	var ray_collider = ray_cast_3d.get_collider()
	if ray_collider:
		if ray_collider is StaticBody3D:
			if ray_collider.find_parent("CellDoor"):
				crosshair.visible = true
				left_mouse.visible = true
		if ray_collider is RigidBody3D:
			crosshair.visible = true
			left_mouse.visible = true
	else:
		crosshair.visible = false
		left_mouse.visible = false
		
		
	camera_positioner()
		
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if not paused and possessed:
		input_dir = Input.get_vector("s", "w", "a", "d")
	else:
		input_dir = Vector2.ZERO
		
	var current_velocity = Vector2(movement_velocity.x, movement_velocity.z)
	var direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	
	if direction and not paused:
		current_velocity = lerp(current_velocity, Vector2(direction.x, direction.z) * speed, acceleration)
	else:
		current_velocity = current_velocity.move_toward(Vector2.ZERO, acceleration)
	
	movement_velocity = Vector3(current_velocity.x, velocity.y, current_velocity.y)
	velocity = movement_velocity
		
	move_and_slide()
	
																	 
																	 
