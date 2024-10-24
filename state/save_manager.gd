extends Node

const Constants = preload("res://scripts/constants.gd")

const save_prefix: String = "save_game"
const file_extension: String = "json"
const user_folder: String = "user://"
const save_folder: String = "saved_games"
const save_function: String = "save"
const load_function: String = "load"

func save_game() -> void:
	var save_data: Dictionary[String, Dictionary] = {}
	var save_nodes: Array[Node] = get_tree().get_nodes_in_group(Constants.PERSIST_GROUP)
	for node in save_nodes:
		if !node.has_method(save_function):
			print("Node '%s' is missing a %s() function, skipped" % [node.name, save_function])
			continue

		var node_data: Dictionary[String, Variant] = node.call(save_function)
		save_data[node.name] = node_data
	_save_data_to_file(save_data)

func load_recent_game() -> void:
	var recent_save: String = _get_most_recent_save_from_folder()
	load_data_from_file(recent_save)

func load_data_from_file(filename: String) -> void:
	if not FileAccess.file_exists(filename):
		return

	var saved_file: FileAccess = FileAccess.open(filename, FileAccess.READ)
	var file_as_string: String = saved_file.get_as_text()
	var json := JSON.new()

	var parse_result: Error = json.parse(file_as_string)
	if not parse_result == OK:
		print("JSON Parse Error: %s in %s at line %d" % [
			json.get_error_message(), 
			file_as_string,
			 json.get_error_line()
		])
		return
	var json_data: Dictionary[String, Dictionary] = {}
	json_data.merge(json.data)
	_load_data_in_nodes(json_data)

func _save_data_to_file(save_data: Dictionary[String, Dictionary]) -> void:
	var save_directory: String = "%s%s/" % [user_folder, save_folder]
	_validate_or_create_save_directory(save_directory)
	var filename: String = _create_timestampped_filename()
	var filepath: String = "%s%s" % [save_directory, filename]
	var file: FileAccess = FileAccess.open(filepath, FileAccess.WRITE)

	if !file:
		print("Error opening file for saving.")
		return

	var save_string: String = JSON.stringify(save_data, "\t")
	file.store_string(save_string)
	file.close()
	print("Game saved successfully as %s" % filepath)

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

func _get_most_recent_save_from_folder() -> String:
	var save_directory: String = "%s%s/" % [user_folder, save_folder]
	var dir: DirAccess = DirAccess.open(save_directory)
	if !dir:
		print("Could not open 'saved_games' directory.")
		return ""

	var save_files: Array[String] = []
	dir.list_dir_begin()
	var file_name: String = dir.get_next()
	while file_name:
		if file_name.begins_with(save_prefix) and file_name.ends_with(file_extension):
			save_files.append(file_name)
		file_name = dir.get_next()
	save_files.sort()

	if save_files.is_empty():
		print("No save files found in '%s'." % save_directory)
		return ""
	
	return "%s%s" % [save_directory, save_files[save_files.size() - 1]]

func _load_data_in_nodes(data: Dictionary[String, Dictionary]) -> void:
	var load_nodes: Array[Node] = get_tree().get_nodes_in_group(Constants.PERSIST_GROUP)
	for node: Node in load_nodes:
		if !node.has_method(load_function):
			print("Node '%s' is missing a %s() function, skipped." % [node.name, load_function])
			continue

		if !data.has(node.name):
			print("Save is missing data for the %s node." % node.name)
			continue
		var node_data: Dictionary[String, Variant] = {}
		node_data.merge(data[node.name])
		node.call(load_function, node_data)
 
