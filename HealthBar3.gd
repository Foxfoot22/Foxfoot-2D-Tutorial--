extends Control

onready var health_over = $HealthOver
onready var health_under = $HealthUnder
onready var update_tween = $UpdateTween

export (Color) var healthy_color = Color.green
export (Color) var caution_color = Color.yellow
export (Color) var danger_color = Color.red
export (float, 0, 1, 0.05) var caution_zone = 0.5
export (float, 0, 1, 0.05) var danger_zone = 0.2

signal play_onhit_sfx

func _on_health_updated(health):
	health_over.value = health
	update_tween.interpolate_property(health_under, "value", health_under.value, 0.4, Tween.TRANS_SINE, Tween.EASE_IN_OUT, 0.4)
	update_tween.start()
	emit_signal("play_onhit_sfx")
	
	_assign_color(health)
	
func _assign_color(health):
	if health < health_over.max_value * danger_zone:
		health_over.tint_progress = danger_color
	elif health < health_over.max_value * caution_zone:
		health_over.tint_progress = caution_color
	else:
		health_over.tint_progress = healthy_color
		##set_modulate(Color(0,1,0,0.4))

func _on_max_health_updated(max_health):
	health_over.max_value = max_health
	health_under.max_value = max_health
	print("max_health")
	print(max_health)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


func _on_Main_starting_health():
	_on_health_updated(100)
	_on_max_health_updated(100)