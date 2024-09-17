extends Node

signal reward_player_signal(reward: ItemBundle)
signal update_inventory_signal
signal player_assigned_to_work

func reward_player(reward: ItemBundle) -> void:
	reward_player_signal.emit(reward)

func inventory_updated() -> void:
	update_inventory_signal.emit()

func player_being_assigned_to_work() -> void:
	player_assigned_to_work.emit()
