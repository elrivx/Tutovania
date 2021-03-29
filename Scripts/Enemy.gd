extends KinematicBody2D

var dead = false

func _process(delta):
	if dead == false:
		$EnemySprite.play("Idle")

