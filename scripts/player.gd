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

var is_holding_pannel : bool = false
var hold_pannel
var ray_parent
						  
func _input(_event: InputEvent) -> void:
	if _event is InputEventMouseMotion and possessed and not paused and is_camera_mode:
		Camera.rotation.x += -_event.screen_relative.y * mouse_sense
		self.rotation.y += -_event.screen_relative.x * mouse_sense
	if possessed:
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
			if is_holding_pannel:
				hold_pannel.reparent(ray_parent)
				is_holding_pannel = false	
				hold_pannel.freeze = false
				hold_pannel = null
				return	
			if not is_camera_mode and not is_holding_pannel:
				var ray_collider = ray_cast_3d.get_collider()
				if ray_collider is RigidBody3D:
					if ray_collider.get_parent().name == "SjPannels3D":
						ray_parent = ray_collider.get_parent()
						hold_pannel = ray_collider
						hold_pannel.reparent(Camera)
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
