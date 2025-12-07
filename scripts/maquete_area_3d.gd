extends Area3D

var maquete

func _ready() -> void:
	connect("body_entered", fix_model)
	maquete = get_parent().get_parent()
	
var offset : Vector3 = Vector3(-.55,-.75,.70)

func fix_model(body) -> void:
	match name:
		"TerreoArea3D":
			if body is RigidBody3D:
				if body.name == "MaqueteTerreo":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", offset, .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					maquete.fixed_model_count += 1
					maquete.puzzle_check()
					return
		"SegundoArea3D":
			if body is RigidBody3D:
				if body.name == "MaqueteSegundo":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", offset + Vector3(0,.40, 0), .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					maquete.fixed_model_count += 1
					maquete.puzzle_check()
					return
		"CoberturaArea3D":
			if body is RigidBody3D:
				if body.name == "MaqueteCob":
					var player = body.find_parent("Player")
					if player:
						player.drop_pannel()
					body.reparent(self)
					body.freeze = true
					var tween = create_tween()
					tween.set_parallel()
					tween.tween_property(body, "position", offset + Vector3(0,-.2, 0), .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					maquete.fixed_model_count += 1
					maquete.puzzle_check()
					return
