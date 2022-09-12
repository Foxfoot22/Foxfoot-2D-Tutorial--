extends Area2D
# warning-ignore:unused_signal

export var speed = 400
export (int) var health = 100 setget set_health
export var amount = 10



var screen_size
var target = Vector2()

signal player_hit
signal health_depleted
signal food_sound
signal mob_sound


func _ready():	
	hide()
	screen_size = get_viewport_rect().size

	
func _on_Main_starting_health():
	set_health(100)
	$CollisionShape2D.disabled = false
	
func set_health(value):
	health = value
	print("setting health")
	print(value)

	
func start(pos):
	target = pos
	show()




 
func _input(event):

	if event is InputEventScreenTouch and event.pressed:
		target = event.position
		#$AnimatedSprite.position = event.position	
		#$CollisionShape2D.position = event.position	

	if event is InputEventMouseMotion:
		target = event.position
		# While dragging, move the sprite with the mouse.
		##$AnimatedSprite.position = event.position
		##$CollisionShape2D.position = event.position	
		
	
func _process(delta):
	var velocity = Vector2()
	
	if position.distance_to(target) > 10:
		velocity = target - position
	

	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play()
	else:
		$AnimatedSprite.stop()
	
	position += velocity * delta
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)
	
	if velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	elif velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	##_on_Player_body_entered(self)

func _on_Player_body_entered(body):
	
	if body.is_in_group("food"):
		body.queue_free()
		health += 1
		emit_signal("food_sound")
		
	else:
		health -= 10
		emit_signal("mob_sound")
	set_health(health)
	emit_signal("player_hit", health)


	if health < 0.1:
		emit_signal("health_depleted")
		$CollisionShape2D.set_deferred("disabled", true)	
# Must be deferred as we can't change physics properties on a physics callback.
	else:
		$CollisionShape2D.set_deferred("disabled", false)	
	



