class_name Util
extends Node

static func are_null(node: Node) -> bool:
	return node == null

static func clear_children(node: Node) -> void:
	for child: Node in node.get_children():
		node.remove_child(child)
		child.queue_free()
