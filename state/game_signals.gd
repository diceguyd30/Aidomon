extends RefCounted

signal reward_player_signal(reward: ItemBundle)
signal update_inventory_signal

func reward_player(reward: ItemBundle) -> void:
	reward_player_signal.emit(reward)

func inventory_updated() -> void:
	update_inventory_signal.emit()
