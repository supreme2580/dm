class_name Enemy extends CharacterBody3D

@onready var animationPlayer = $enemy/AnimationPlayer
@onready var prompt = $EnemyInteractionPrompt
@export var player: Player

@export var detection_radius: float = 50.0
@export var collision_offset: float = 12.0

var enemy_activated = false

func _ready():
	prompt.hide()

func _physics_process(_delta: float) -> void:
	if not animationPlayer.is_playing():
		animationPlayer.play("idle_pet")
	
	if player:
		var distance = max(global_position.distance_to(player.global_position) - collision_offset, 0.0)
		
		if distance <= detection_radius:
			prompt.show()
			if distance <= 1.0:
				prompt.text = "activating enemy..."
				await get_tree().create_timer(3.0).timeout
				enemy_activated = false
			else:
				prompt.text = "%.1f m away" % distance
		else:
			prompt.hide()
