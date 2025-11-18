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
			pass
			# open camera


@onready var camera_3d: Camera3D = $CellPhone/ScreenContainer/Frame/MarginContainer/Camera/SubViewportContainer/SubViewport/Camera3D

func camera_positioner() -> void:
	if possessed and Camera != null:
		camera_3d.position = Camera.global_position
		camera_3d.rotation = Camera.global_rotation + Vector3(0,0,deg_to_rad(90))

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
