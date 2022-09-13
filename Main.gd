extends Node

export(PackedScene) var mob_scene
export(PackedScene) var food_scene
export(PackedScene) var food_scene2
export(PackedScene) var big_fish_scene


var score
var value

signal starting_health
##signal fish_bite

# Called when the node enters the scene tree for the first time.

func _ready():
	randomize()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$BigFishTimer.stop()
	$HUD.show_game_over()
	$Music.stop()
	$DeathSound.play()
	$OnHit.stop()
	$EatSound.stop()
	
func new_game():
	score = 0
	emit_signal("starting_health")
	##$Player.set_health(100)
	$Player.start($StartPosition.position)
	$StartTimer.start()
	$BigFishTimer.start()
	$HUD.update_score(score)
	$HUD.show_message("Get Ready")
	get_tree().call_group("mobs", "queue_free")
	$Music.play()
	$OnHit.stop()
	$EatSound.stop()

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)
	$OnHit.stop()
	$EatSound.stop()
	
func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()
	
func _on_MobTimer_timeout():
	var mob = mob_scene.instance()
	var food = food_scene.instance()
	var more_food = food_scene2.instance()
	
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()
	
	var direction = mob_spawn_location.rotation + PI / 2
	
	mob.position = mob_spawn_location.position
	food.position = mob_spawn_location.position
	more_food.position = mob_spawn_location.position
	
	direction += rand_range(-PI / 4, PI / 4)
	mob.rotation = direction
	food.rotation = direction
	direction += rand_range(-PI / 4, PI / 4)
	more_food.rotation = direction

	
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)
	##food.linear_velocity = velocity.rotated(direction)
	more_food.linear_velocity = velocity.rotated(direction)

	add_child(mob)
	add_child(food)
	add_child(more_food)

 # Replace with function body.


func _on_Player_health_depleted():
	game_over() 



func _on_HealthBar_play_onhit_sfx():
	##$OnHit.play()
	pass

func _on_Player_food_sound():
	$EatSound.play()


func _on_Player_mob_sound():
	$OnHit.play()


func _on_BigFishTimer_timeout():

	var big_fish = big_fish_scene.instance()

	add_child(big_fish)
	
func on_fish_bite():
	print("fish bite")
