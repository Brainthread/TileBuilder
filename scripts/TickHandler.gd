extends Node2D

signal ticked
@onready var build_manager = $"../BuildManager"

func _ready():
	build_manager.tile_placed.connect(_on_tile_placed)

func _on_tile_placed(tile, subtiles):
	ticked.emit()
	print("TICKED")
