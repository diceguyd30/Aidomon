class_name MainMenu
extends Control

const AIDOMON = preload("res://scenes/aidomon.tscn")
@onready var file_dialog: FileDialog = $FileDialog

func _on_continue_btn_pressed() -> void:
	SaveManager.load_recent_game()
	_change_to_main_scene()

func _on_new_game_btn_pressed() -> void:
	_change_to_main_scene()

func _on_load_game_btn_pressed() -> void:
	file_dialog.popup_centered()

func _on_quit_btn_pressed() -> void:
	get_tree().quit()

func _on_file_dialog_file_selected(path: String) -> void:
	SaveManager.load_data_from_file(path)
	_change_to_main_scene()

func _change_to_main_scene() -> void:
	get_tree().change_scene_to_packed(AIDOMON)
