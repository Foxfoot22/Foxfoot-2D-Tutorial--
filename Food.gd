extends RigidBody2D

signal eat_me
# Declare member variables here. Examples:

# Called when the node enters the scene tree for the first time.
func _ready():
	$FoodSprite.playing = true
	var mob_types = $FoodSprite.frames.get_animation_names()
	$FoodSprite.animation = mob_types[randi() % mob_types.size()]


func _on_FoodVisNotice2D_screen_exited():
	queue_free() 


func _on_Food_body_entered(_body):
	emit_signal("eat_me")
	queue_free() 
	
