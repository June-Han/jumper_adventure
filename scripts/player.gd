extends CharacterBody2D

#IMPORTANT!
#Player is on Collision Layer 2, the monsters are on collision layer 2. Layer 2 is made solely for monster interactions!

const SPEED = 100.0
const JUMP_VELOCITY = -300.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var animated_sprite = $AnimatedSprite2D

@onready var attack_collision_left = $AttackArea/CollisionShape2DLeft
@onready var attack_collision_right = $AttackArea/CollisionShape2DRight

@onready var idle_collision = $IdleArea/CollisionShape2D
@onready var crouch_collision = $CrouchCollisionShape2D

var isAttacking = false
var isCrouching = false

func _physics_process(delta):
	#Set Default Collision Area
	#Original crouch collision will be enabled by default (Idle will be secondary)
	#Otherwise there will be no collision area to hold the character on the platforms 
	#during the transition where the original collision area of player if turned off from crouching collision to come in
	attack_collision_left.disabled = true
	attack_collision_right.disabled = true
	
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_just_pressed("jump_up") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration. Input direction is -1, 0, 1 (-1 is left, 1 is right and 0 is still)
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("move_left", "move_right")
	
	#Flipping Sprite based on Direction
	if direction > 0:
		animated_sprite.flip_h = false
	elif direction <0: 
		animated_sprite.flip_h = true
	
	#Handling Animation based on direction and position
	if is_on_floor():
		#Play Animation
		if direction == 0:
			if Input.is_action_just_pressed("crouch_down"): # When the user press the down or s button
				animated_sprite.play("crouch")
				
			elif Input.is_action_pressed("crouch_down"): # If the user holds the down or the s button
				animated_sprite.play("crouch_hold")
				isAttacking = false
				isCrouching = true
				
			elif Input.is_action_pressed("attack1") or Input.is_action_just_pressed("attack1"):
				animated_sprite.play("attack1")
				isAttacking = true
				isCrouching = false
				
			else:
				animated_sprite.play("idle")
				isAttacking = false
				isCrouching = false
				
		else:
			animated_sprite.play("run")
			isAttacking = false
			isCrouching = false
			
	else:
		animated_sprite.play("jump")
		isAttacking = false
		isCrouching = false
		
	
	#Apply collision area based on user actions
	if isCrouching == true and isAttacking == false:
		idle_collision.disabled = true
		attack_collision_left.disabled = true
		attack_collision_right.disabled = true
		
	elif isAttacking == true and isCrouching == false:
		idle_collision.disabled = false
		if animated_sprite.flip_h == true: #Turning to the left
			attack_collision_left.disabled = false
			attack_collision_right.disabled = true
		if animated_sprite.flip_h == false: #Turning to the right
			attack_collision_right.disabled = false
			attack_collision_left.disabled = true
	else:
		idle_collision.disabled = false
		attack_collision_left.disabled = true
		attack_collision_right.disabled = true
	
	#Apply movement based on direction
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
