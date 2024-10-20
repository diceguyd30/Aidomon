class_name MainMenu
extends Control

const AIDOMON = preload("res://scenes/aidomon.tscn")

func _on_continue_btn_pressed() -> void:
	SaveManager.load_recent_game()
	get_tree().change_scene_to_packed(AIDOMON)

func _on_new_game_btn_pressed() -> void:
	get_tree().change_scene_to_packed(AIDOMON)

func _on_load_game_btn_pressed() -> void:
	pass # Replace with function body.

func _on_quit_btn_pressed() -> void:
	get_tree().quit()
