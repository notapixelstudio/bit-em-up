extends Node2D

class_name Piece

signal fail
signal hit

# variables
var speed = 250

func tick(animation = "Dance"):
	anim.play(animation)

var check_moves = []


onready var anim = $Sprite/AnimationPlayer
var last_pos = Vector2()
var move_dir = Vector2()

signal move
signal winner
	

# functions
func _ready():
	add_to_group("moving")

	
func action(pos, move_type,  tick = 0) -> bool:
	
	if move_dir == Vector2.ZERO:
		emit_signal("fail")
		return false
	emit_signal("hit")
	return true
	
	
signal capture

func nope():
	print("YOU SHALL NOT PASS")
	
func get_movedir():
	pass

var check_pos = Vector2()

var in_check = false

