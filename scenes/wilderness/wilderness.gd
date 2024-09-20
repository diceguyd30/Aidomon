extends Control

func _on_activity_pressed() -> void:
	GameSignals.player_being_assigned_to_work()
