@tool

extends EditorPlugin

var last_pos
var following := true    # auto enabled for testing

func _handles(object):
	return true

func _forward_3d_gui_input(camera: Camera3D, event: InputEvent) -> int:
	if not following:
		return false

	# ALT must be held
	if not Input.is_key_pressed(KEY_ALT):
		last_pos = null
		return false

	var selection = get_editor_interface().get_selection()
	var selected = selection.get_selected_nodes()
	if selected.is_empty():
		return false

	var obj = selected[0]
	if obj:
		var pos = obj.global_transform.origin

		if last_pos != null and pos != last_pos:
			var delta = pos - last_pos
			if camera:
				var t = camera.global_transform
				t.origin += delta
				camera.global_transform = t

		last_pos = pos

	return false
