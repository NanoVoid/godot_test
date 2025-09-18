extends RichTextLabel

@onready var length_slider: HSlider = $".."
@onready var parent_node = get_node("/root/Node2D")

func _ready():
	self.text = str(length_slider.value)
	parent_node.option_password_length = length_slider.value
	return

func _on_length_slider_value_changed(value: float) -> void:
	self.text = str(length_slider.value)
	parent_node.option_password_length = length_slider.value
	return
