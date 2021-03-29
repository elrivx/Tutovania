extends KinematicBody2D

# Variables & Constants

const UP = Vector2(0, -1)
const GRAVITY = 20
const MAXFALLSPEED = 200
const MAXSPEED = 150
const JUMPFORCE = 300


var motion= Vector2()
var isAttacking = false

# Functions

func _physics_process(delta):

  motion.y += GRAVITY
  if motion.y > MAXFALLSPEED:
	  motion.y = MAXFALLSPEED

  motion.x = clamp(motion.x, -MAXSPEED, MAXSPEED)
  
  if Input.is_action_pressed("ui_right") && isAttacking == false:
	   motion.x = MAXSPEED
	   $Sprite.flip_h = false
	   $Sprite.play("Walk")     
  elif Input.is_action_pressed("ui_left") && isAttacking == false:
	  motion.x = -MAXSPEED
	  $Sprite.flip_h = true
	  $Sprite.play("Walk")    
  else:
	  if isAttacking == false:
	   $Sprite.play("Idle")    
   motion.x = lerp(motion.x, 0, 0.2)

  if Input.is_action_just_pressed("Attack"):
		 $Sprite.play("Attack")
		 isAttacking = true
		 $AttackArea/CollisionShape2D.disabled == false
	

  if is_on_floor():
	  if Input.is_action_just_pressed("Jump"):		  
		  motion.y = -JUMPFORCE
  else:
	  $Sprite.play("Jump")

  motion = move_and_slide(motion, UP)



func _on_Sprite_animation_finished():
	if $Sprite.animation == "Attack":
		$AttackArea/CollisionShape2D.disabled == true
		isAttacking = false
	
