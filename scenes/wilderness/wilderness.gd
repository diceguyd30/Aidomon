@tool
extends Control

func _on_activity_pressed() -> void:
	GameSignals.player_being_assigned_to_work()

func _on_activity_completed(item_bundle: ItemBundle) -> void:
	GameSignals.reward_player(item_bundle)

func _on_creature_activity_completed(_item_bundle: ItemBundle) -> void:
	print("Creature found......maybe")
