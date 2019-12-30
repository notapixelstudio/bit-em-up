extends Piece

onready var label = $Debug/Label

var keys = {
	'left': false,
	'right': false,
	'up': false,
	'down': false
}

var swipe_start = null
var minimum_drag = 100

const tolerance = 0.2

func _ready():
	remove_from_group("moving")
	
func _input(event):
	check_key(event, 'left')
	check_key(event, 'right')
	check_key(event, 'up')
	check_key(event, 'down')

func _unhandled_input(event):
	if event.is_action_pressed("click"):
		swipe_start = get_global_mouse_position()
	if event.is_action_released("click"):
		_calculate_swipe(get_global_mouse_position())

func wait_and_release(direction):
	yield(get_tree().create_timer(tolerance*2), 'timeout')
	keys[direction] = false
		
const THRESHOLD = 50     
func _calculate_swipe(swipe_end):
	if swipe_start == null: 
		return
	var swipe = swipe_end - swipe_start
	print(swipe)
	if abs(swipe.x) > minimum_drag:
		if swipe.x > 0 :
			print("right")
			keys["right"] = true
			wait_and_release("right")
		elif swipe.x < 0 :
			keys["left"] = true
			wait_and_release("left")
	if abs(swipe.y) > minimum_drag:
		if swipe.y < 0 :
			keys["up"] = true
			wait_and_release("up")
		elif swipe.y > 0 :
			keys["down"] = true
			wait_and_release("down")
	print(keys)

func check_key(event, k):
	if event.is_action_pressed('ui_'+k):
		keys[k] = true
		yield(get_tree().create_timer(tolerance*2), 'timeout')
		keys[k] = false
	elif event.is_action_released('ui_'+k):
		yield(get_tree().create_timer(tolerance), 'timeout')
		keys[k] = false
	
# CONTROL KEYS
func tick(animation="Dance"):
	move_dir.y = -int(keys['left']) + int(keys['right'])
	move_dir.x = -int(keys['down']) + int(keys['up'])
	label.text = ""
	label.modulate = Color(1,1,1)
	for k in keys:
		if keys[k]:
			label.text = k
	if action(move_dir, "input"):
		.tick()
	else:
		.tick("Miss")
		label.text = "MISS!"
		label.modulate = Color(1,0,0)
	return move_dir

func _on_TouchScreenButton4_pressed():
	keys["up"] = true
	keys["left"] = true
	yield(get_tree().create_timer(tolerance*2), 'timeout')
	keys["up"] = false
	keys["left"] = false
	


func _on_TouchScreenButton11_pressed():
	keys["down"] = true
	keys["left"] = true
	yield(get_tree().create_timer(tolerance*2), 'timeout')
	keys["down"] = false
	keys["left"] = false


func _on_TouchScreenButton6_pressed():
	keys["up"] = true
	keys["right"] = true
	yield(get_tree().create_timer(tolerance*2), 'timeout')
	keys["up"] = false
	keys["right"] = false


func _on_TouchScreenButton10_pressed():
	keys["down"] = true
	keys["right"] = true
	yield(get_tree().create_timer(tolerance*2), 'timeout')
	keys["down"] = false
	keys["right"] = false
