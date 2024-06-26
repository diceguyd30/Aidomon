class_name EnvironmentItemGenerator
extends Object

signal generate_object(env_item: EnvironmentItem)

var environment_items: Array[EnvironmentItem]
var timer: Timer

func _init(env_items: Array[EnvironmentItem] = []):
	self.environment_items = env_items
	self.timer = Timer.new()
