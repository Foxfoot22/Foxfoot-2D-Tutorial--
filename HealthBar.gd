extends ProgressBar

var current_health = self.get_value()
var new_health
var player_new_health

signal update_health
# Called when the node enters the scene tree for the first time.
func _ready():
	pass


func _on_Health_max_changed(new_max):
	self.set_max(new_max)



func _on_Player_update_health():
	
	new_health = current_health - 1.0
	set_value(new_health)
	player_new_health = NodePath("Main/Player:max_health:new_health")
	##emit_signal("player_new_health", player_new_health)

	print(new_health)
	
##func update_health(new_value):
	##bar.value = new_value
