extends Node

signal reward_player_signal(reward: ItemBundle)

func reward_player(reward: ItemBundle) -> void:
	reward_player_signal.emit(reward)
