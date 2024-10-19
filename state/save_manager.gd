extends Node

const Constants = preload("res://scripts/constants.gd")

const save_prefix: String = "save_game"
const file_extension: String = "json"
const user_folder: String = "user://"
const save_folder: String = "saved_games"

func save_game() -> void:
	var save_data: Dictionary[String, Dictionary] = {}
	var save_nodes: Array[Node] = get_tree().get_nodes_in_group(Constants.PERSIST_GROUP)
	for node in save_nodes:
		# Check the node is an instanced scene so it can be instanced again during load.
		if node.scene_file_path.is_empty():
			print("persistent node '%s' is not an instanced scene, skipped" % node.name)
			continue

		# Check the node has a save function.
		if !node.has_method("save"):
			print("persistent node '%s' is missing a save() function, skipped" % node.name)
			continue

		# Call the node's save function.
		var node_data: Dictionary[String, Variant] = node.call("save")
		save_data[node.name] = node_data
	_save_data_to_file(save_data)

func load_game(_path: String) -> void:
	pass

func _save_data_to_file(save_data: Dictionary[String, Dictionary]) -> void:
	var save_directory: String = "%s%s/" % [user_folder, save_folder]
	_validate_or_create_save_directory(save_directory)
	var filename: String = _create_timestampped_filename()
	var filepath: String = "%s/%s" % [save_directory, filename]
	var file: FileAccess = FileAccess.open(filepath, FileAccess.WRITE)

	if !file:
		print("Error opening file for saving.")
		return

	var save_string: String = JSON.stringify(save_data)
	file.store_string(save_string)
	file.close()
	print("Game saved successfully as %s!" % filepath)

func _validate_or_create_save_directory(directory_path: String) -> void:
	var dir: DirAccess = DirAccess.open(directory_path)
	if not dir:
		var dir_create: DirAccess = DirAccess.open(user_folder)
		dir_create.make_dir(save_folder)

func _create_timestampped_filename() -> String:
	var datetime: Dictionary = Time.get_datetime_dict_from_system()
	var datetime_string: String = "%s-%s-%s_%s-%s-%s" % [
		str(datetime.year), 
		str(datetime.month).pad_zeros(2), 
		str(datetime.day).pad_zeros(2),
		str(datetime.hour).pad_zeros(2),
		str(datetime.minute).pad_zeros(2),
		str(datetime.second).pad_zeros(2)
	]
	return "%s_%s.%s" % [save_prefix, datetime_string, file_extension]
