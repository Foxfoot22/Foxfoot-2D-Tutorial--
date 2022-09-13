extends RigidBody2D


signal fish_bite

func _on_BigFish_tree_entered():
	var target = get_parent()
# warning-ignore:return_value_discarded
	self.connect("fish_bite", target, "on_fish_bite")
	
	if is_connected("fish_bite", target, "on_fish_bite"):
		print("connected")
	
func _ready():
	pass
	
		

func _on_RigidBody2D_body_entered(body):
	print("body entered")
	##get_tree().call_group("Main", "on_fish_bite")
	emit_signal("fish_bite")
	body.queue_free()
	
func _on_VisibilityNotifier2D_screen_exited():
	queue_free() 

