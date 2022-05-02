tool
extends EditorPlugin

var panel_instance

onready var dock = get_node("/root/EditorNode/@@592/@@593/@@601/@@603/@@607/@@611/@@612/@@613/@@4742/@@4743")
onready var shader_editor = get_node("/root/EditorNode/@@592/@@593/@@601/@@603/@@607/@@611/@@612/@@613/@@4742/@@4743/@@7844")

func get_plugin_name():
	return "Shader"

func get_plugin_icon():
	return get_editor_interface().get_base_control().get_icon("Shader", "EditorIcons")
	
func _enter_tree():
	yield(get_tree(), "idle_frame")
	yield(get_tree(), "idle_frame")
	
	panel_instance = PanelContainer.new()
	panel_instance.name = "Shader"
	panel_instance.theme = get_theme(shader_editor)
	add_control_to_dock(DOCK_SLOT_LEFT_UR, panel_instance)
	make_visible(true)
	panel_instance.size_flags_vertical = 3
	panel_instance.size_flags_horizontal = 3

	for child in shader_editor.get_children():
		shader_editor.remove_child(child)
		panel_instance.add_child(child)
	make_visible(false)
	
	dock.remove_child(shader_editor)

func _exit_tree():
	dock.add_child(shader_editor)
	
	for child in panel_instance.get_children():
		panel_instance.remove_child(child)
		shader_editor.add_child(child)
	
	if panel_instance:
		remove_control_from_docks(panel_instance)
		panel_instance.queue_free()
		
func handles(object):
	if not panel_instance:
		return false
	if panel_instance.visible:
		return true
	if object is Shader:
		return true
	return false

func make_visible(visible):
	if panel_instance:
		panel_instance.visible = visible

func get_theme(control):
	var theme = null
	while control != null && "theme" in control:
		theme = control.theme
		if theme != null: break
		control = control.get_parent()
	return theme
