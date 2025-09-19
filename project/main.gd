extends Node2D

const CHARACTERS_UPPERCASE = ['a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z']
const CHARACTERS_LOWERCASE = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']
const CHARACTERS_NUMBERS = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9']
const CHARACTERS_SPECIAL = ['`', '!', '@', '#', '$', '%', '^', '&', '*', '(', ')', '-', '_', '=', '+', '[', ']', '{', '}', ';', ':', '"', ',', '<', '.', '>', '/', '?']


@export var option_password_length : int = 14
@export var option_uppercase : bool = true
@export var option_lowercase : bool = true
@export var option_numbers : bool = true
@export var option_special : bool = false
@onready var options = [option_uppercase, option_lowercase, option_numbers, option_special]

@onready var output_text_edit: TextEdit = $Control/Output_TextEdit

@onready var uppercase: CheckBox = $Control/Options_Control/Options_List/Uppercase
@onready var lowercase: CheckBox = $Control/Options_Control/Options_List/Lowercase
@onready var numbers: CheckBox = $Control/Options_Control/Options_List/Numbers
@onready var special: CheckBox = $Control/Options_Control/Options_List/Special
@onready var usable_characters = []

func _ready():
	# set button_pressed state to export values
	uppercase.button_pressed = option_uppercase
	lowercase.button_pressed = option_lowercase
	numbers.button_pressed = option_numbers
	special.button_pressed = option_special
	pass

func _process(_delta) -> void:
	pass

func generate_usable_characters() -> void:
	usable_characters.clear()
	if uppercase.button_pressed:
		usable_characters.append_array(CHARACTERS_UPPERCASE)
	if lowercase.button_pressed:
		usable_characters.append_array(CHARACTERS_LOWERCASE)
	if numbers.button_pressed:
		usable_characters.append_array(CHARACTERS_NUMBERS)
	if special.button_pressed:
		usable_characters.append_array(CHARACTERS_SPECIAL)
	return

func generate_character():
	if len(usable_characters) < 1:
		return null 
	var rng_num = randi_range(0, len(usable_characters) - 1)
	return usable_characters[rng_num]
	
func generate_password() -> String:
	var generated_password : String = ""
	for i in option_password_length:
		generated_password += generate_character()
	return generated_password


func _on_button_pressed() -> void:
	generate_usable_characters()
	if len(usable_characters) >= 1:
		output_text_edit.text = generate_password()
	else:
		output_text_edit.text = "Please select at least one character type"


func _on_copy_button_pressed() -> void:
	DisplayServer.clipboard_set(output_text_edit.text)
