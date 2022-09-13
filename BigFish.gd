extends RigidBody2D


signal fish_bite
var bite_signal = emit_signal("fish_bite")

# Called when the node enters the scene tree for the first time.
func _ready():
	
	var target = get_parent()
	self.connect("fish_bite", target, "on_fish_bite")
	
	if is_connected("fish_bite", target, "on_fish_bite"):
		print("connected")
		

func _on_RigidBody2D_body_entered(body):
	print("body entered")
	body.queue_free()
	##get_tree().call_group("Main", "on_fish_bite")
	emit_signal("fish_bite")
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() 

