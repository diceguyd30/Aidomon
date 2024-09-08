class_name CharacterInteractions
extends Control

@onready var party_btn: Button = $PanelContainer/MarginContainer/HBoxContainer/MarginContainer/VBoxContainer/PartyBtn
@onready var party: Control = $PanelContainer/MarginContainer/HBoxContainer/Party
@onready var story: Control = $PanelContainer/MarginContainer/HBoxContainer/Story
@onready var encounters: Control = $PanelContainer/MarginContainer/HBoxContainer/Encounters
@onready var trainers: Control = $PanelContainer/MarginContainer/HBoxContainer/Trainers

func _ready() -> void:
	party_btn.grab_focus()

func _on_party_btn_pressed() -> void:
	party.visible = true
	story.visible = false
	encounters.visible = false
	trainers.visible = false

func _on_story_btn_pressed() -> void:
	party.visible = false
	story.visible = true
	encounters.visible = false
	trainers.visible = false

func _on_encounters_btn_pressed() -> void:
	party.visible = false
	story.visible = false
	encounters.visible = true
	trainers.visible = false

func _on_trainers_btn_pressed() -> void:
	party.visible = false
	story.visible = false
	encounters.visible = false
	trainers.visible = true
