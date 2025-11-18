extends Area3D

func _on_body_entered(body: Node3D) -> void:
	if body is CharacterBody3D:
		if not body.cell_phone.camera_tuto_complete:
			body.cell_phone.notification_page = body.cell_phone.notification_enum.camera_tuto
			body.cell_phone.notify()
		
