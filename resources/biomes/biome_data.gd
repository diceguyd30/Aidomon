class_name BiomeData
extends Resource

@export var id: int
@export var name: String
@export var background: Texture
@export var environment_items: Array[EnvironmentItemData] = []
@export var native_creatures: Dictionary[float, Creature] = {}
