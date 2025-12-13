extends Area3D

var bell_empty : bool = true

func _ready() -> void:
	self.body_entered.connect(fix_bell)
	
func fix_bell(body) -> void:
	if body is RigidBody3D and bell_empty:
		body.reparent(self)
		body.freeze = true
		var tween = create_tween()
		tween.set_parallel()
		tween.tween_property(body, "position", Vector3.ZERO, .5)
		tween.tween_property(body, "rotation", Vector3.ZERO, .5)
		await  tween.finished
		bell_empty = false
		self.get_parent().bell_count += 1
		return
