extends Area3D

func _ready() -> void:
	connect("body_entered", fix_model)
	
var offset : Vector3 = Vector3(-.70,-.75,.70)

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
					tween.tween_property(body, "position", offset + Vector3(0,.20, 0), .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
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
					tween.tween_property(body, "position", offset - Vector3(0,-.2, 0), .5)
					tween.tween_property(body, "rotation", Vector3.ZERO, .5)
					await  tween.finished
					return
