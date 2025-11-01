extends CanvasLayer

@onready var animation_player: AnimationPlayer = $AnimationPlayer

# This function plays the fade animation (fade to black, then fade back in)
func fade_cycle() -> void:
	animation_player.play("fade")
	await animation_player.animation_finished
