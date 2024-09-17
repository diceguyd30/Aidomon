@tool
extends Control

@export var environment_item: EnvironmentItemData:
	set(value):
		environment_item = value
		_update()

@onready var progress_bar: ProgressBar = %ProgressBar
@onready var timer: Timer = %Timer
@onready var btn_collect: Button = %BtnCollect
@onready var environment_item_icon: TextureRect = %EnvironmentItemIcon
@onready var reward_grid: GridContainer = %RewardGrid

func _ready() -> void:
	if !Engine.is_editor_hint():
		GameSignals.player_assigned_to_work.connect(_unassign_from_work)
	_update()

func _update() -> void:
	if [environment_item_icon, progress_bar, reward_grid] \
			.any(func(x: Node) -> bool: return x == null):
		return
	environment_item_icon.texture = environment_item.icon
	var fill: StyleBoxFlat = progress_bar.get_theme_stylebox("fill")
	fill.bg_color = environment_item.bg_color
	_clear_reward_grid()
	for item: ItemStack in environment_item.reward.item_list:
		var new_texture: TextureRect = TextureRect.new()
		new_texture.texture = item.item.icon
		new_texture.size = Vector2(16, 16)
		reward_grid.add_child(new_texture)

func _clear_reward_grid() -> void:
	for child: Node in reward_grid.get_children():
		reward_grid.remove_child(child)
		child.queue_free()

func _process(_delta: float) -> void:
	if !timer.is_stopped():
		progress_bar.value = ((timer.wait_time - timer.time_left) / timer.wait_time) * 100

func _on_timer_timeout() -> void:
	if !Engine.is_editor_hint():
		GameSignals.reward_player(environment_item.reward)
	timer.start()

func _on_btn_collect_pressed() -> void:
	if !Engine.is_editor_hint():
		GameSignals.player_being_assigned_to_work()
	timer.start()

func _unassign_from_work() -> void:
	progress_bar.value = 0
	timer.stop()
