extends Node2D

var Stars = preload("res://Galaxy/Stars/stars.tscn")

@onready var camera = $Practice

var ready_arms = 0

var arms = []
var Blackhole

var displacement_factor = 0.13
var num_arms = 2 #default number of arms

# Called when the node enters the scene tree for the first time.
func _ready():
	# center the camera
	camera.global_position = Vector2(0,0)
	camera.scale = Vector2(.5,.5)
	
	place_BlackHole()
	
	generate_arms()
	
	$starPaths.generate_paths()
	
func place_BlackHole():
	Blackhole = get_node("Center_Black_Hole")
	Blackhole.scale = Vector2(15 + 5 * num_arms, 15 + 5 * num_arms)
	Blackhole.safeDisfromOthers *= Blackhole.scale.x
	print("Safe Distance from Center: ", Blackhole.safeDisfromOthers)
	
	
func generate_arms():
	for i in range(num_arms):
		var arm = Stars.instantiate()
		arms.append(arm)
		add_child(arm)
		place_arm(arm, i)
		
		
func place_arm(arm, index):
	arm.rotation = (2 * PI * index) / num_arms
	
	var direction = Vector2(-sin(arm.rotation), cos(arm.rotation))
	var offset = direction * Blackhole.safeDisfromOthers * displacement_factor
	arm.global_position = Blackhole.global_position + offset
	
	print("Arm ", index, " : ", arm.global_position)
	
"func set_number_of_arms(value):
	#limit the value to avoid performance issues
	
	value = clamp(value, 2, 10)
	
	num_arms = value
	
	#delete old arms
	for arm in arms:
		arm.queue_free()
	arms.clear()
	
	#generate new arms
	generate_arms()
"

