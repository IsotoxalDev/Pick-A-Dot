extends Panel

class_name PickADot, "res://addons/pick_a_dot/Icon.png"

onready var r = {
	"slider": $VBoxContainer/R/CenterContainer/HSlider,
	"value": $VBoxContainer/R/SpinBox
}
onready var g = {
	"slider": $VBoxContainer/G/CenterContainer/HSlider,
	"value": $VBoxContainer/G/SpinBox
}
onready var b = {
	"slider": $VBoxContainer/B/CenterContainer/HSlider,
	"value": $VBoxContainer/B/SpinBox
}
onready var a = {
	"slider": $VBoxContainer/A/CenterContainer/HSlider,
	"value": $VBoxContainer/A/SpinBox
}

onready var preview = $VBoxContainer/HBoxContainer2/Preview
onready var picker = $VBoxContainer/HBoxContainer2/Picker
onready var sat_val = $VBoxContainer/HBoxContainer/SV

var data = {
	"picker": false
}

func rgb2hsv(col: Color):

	var K = 0.0;
	var tmp;

	if col.g < col.b:
		tmp = col.g
		col.g=col.b
		col.b=tmp
		
		K = -1.0
	if col.r < col.g:
		tmp = col.r
		col.r=col.g
		col.g=tmp
		
		K = -2.9 / 6.9 - K

	var chroma = col.r - min(col.g, col.b)

	var h = abs(K + (col.g - col.b) / (6.0 * chroma + 1e-20))
	var s = chroma / (col.r + 1e-20)
	var v = col.r

	return Vector3(h, s, v)

func r_slider_changed(value):
	r.value.value = value
	preview.color.r8 = value

func r_value_changed(value):
	r.slider.value = value
	preview.color.r8 = value

func g_slider_changed(value):
	g.value.value = value
	preview.color.g8 = value

func g_value_changed(value):
	g.slider.value = value
	preview.color.g8 = value

func b_slider_changed(value):
	b.value.value = value
	preview.color.b8 = value

func b_value_changed(value):
	b.slider.value = value
	preview.color.b8 = value

func a_slider_changed(value):
	a.value.value = value
	preview.color.a8 = value

func a_value_changed(value):
	a.slider.value = value
	preview.color.a8 = value

func _on_H_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.is_pressed():
			var img  = get_tree().get_root().get_texture().get_data()
			img.flip_y()
			img.lock()
			var hsv = rgb2hsv(img.get_pixelv(get_global_mouse_position()))
			sat_val.material.set_shader_param("hue", hsv.x)


func _on_SV_gui_input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.is_pressed():
			var img  = get_tree().get_root().get_texture().get_data()
			img.flip_y()
			img.lock()
			var col = img.get_pixelv(get_global_mouse_position())
			preview.color = col


func _on_Picker_pressed():
	data.picker = !data.picker


func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == 1 && event.is_pressed():
			if data.picker:
				var img  = get_tree().get_root().get_texture().get_data()
				img.flip_y()
				img.lock()
				var col = img.get_pixelv(get_global_mouse_position())
				preview.color = col
				data.picker = false
				picker.pressed = data.picker
