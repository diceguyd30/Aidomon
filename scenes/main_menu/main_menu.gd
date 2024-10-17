class_name MainMenu
extends Control

const AIDOMON_PATH: String = "res://scenes/aidomon.tscn"

func _on_continue_btn_pressed() -> void:
	pass # Replace with function body.

func _on_new_game_btn_pressed() -> void:
	get_tree().change_scene_to_file(AIDOMON_PATH)

func _on_load_game_btn_pressed() -> void:
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
