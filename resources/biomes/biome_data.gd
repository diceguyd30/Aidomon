class_name BiomeData
extends Resource

@export var id: int
@export var name: String
@export var background: Texture
@export var environment_items: Array[EnvironmentItemData] = []

@export_subgroup("Creature Encounters")
## Map of Creature to probability of the species' appearance in the wilderness.
@export var native_species: Dictionary[SpeciesData, float] = {}
@export var min_creature_level: int
@export var max_creature_level: int
