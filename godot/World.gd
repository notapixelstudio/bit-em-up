extends Node2D

export var PIECE_DEF_JSON : String
export var piece_scene : PackedScene
export var tile_size = 64

export var gameover_scene : PackedScene
export var win_scene : PackedScene


onready var timer = $Timer
# keys string in data json
const MOVES = "moves"

var count_tick = 0
const SCROLL_TICK = 5
signal gameover

onready var player = $Player
func _ready():
	player.connect("move", self, "_on_piece_moved", [player])
	
	randomize()


func _on_tick():
	
	count_tick+=1
	player.tick()
	print(player.get_action())


func _on_Player_winner():
	$CanvasLayer/RhythmControl.stop()
	var winner = win_scene.instance()
	$CanvasLayer.add_child(winner)
