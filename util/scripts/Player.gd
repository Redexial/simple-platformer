extends KinematicBody2D


# you can use call(name) to call a functiion by &name
const actions={"jump":[0, -1], "move_right":[1,0], "move_left":[-1,0]}
export (int) var speed = 100
export (int) var jumpHeight = 100
var velocity = Vector2()
var airbound = true
var num = 0
var gravity = Vector2()
var wall = false
var wallSlide=0
var jumps=2

func get_input():
	if not airbound:
		velocity.x = 0
		for action in actions:
			if Input.is_action_pressed(action):
				var jumping = 0
				if Input.is_action_just_pressed("jump"):
					jumping = -1
				else:
					jumping=0
				velocity += Vector2(actions[action][0]*speed, jumping*jumpHeight)
				#if not airbound or jumps>0:
				#	if not wall and action=="jump":
				#		jump()
				#	if action=="jump":
				#		print(jumps)
				#		jumps -=1
				#	airbound = true
				#else:
				#	jumps = 2
				#	velocity.y = 0
	

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	get_input()
	if not test_move(self.transform, Vector2(0,1)):
		airbound = true
	#	wall = true
	var velocityCollision = move_and_collide(velocity*delta)
	if velocityCollision and not test_move(self.transform, Vector2(0,1)):
		velocity = Vector2()
		print("dabs")
	#	if wall == false:
	#		gravity.y = 0
	#		velocity.y=0
	#		wall = true
	#	else:
	#		airbound = false
	#		wallSlide = 5
	if airbound:
		gravity.y += (9.8-wallSlide)*delta
	#
	#if not (test_move(self.transform, Vector2(-1,0)) or test_move(self.transform, Vector2(1,0))):
	#	wall = false
	#else:
	#	wall = true
	var gravityCollision = move_and_collide(gravity)
	if gravityCollision:
	#	wallSlide = 0
		airbound=false
		gravity.y = 0
		velocity.y=0

func jump():
	gravity.y = 0
	velocity.y -= jumpHeight
