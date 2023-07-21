extends StaticBody2D

var star_type = "Red_Giant"
var star_color = Color.RED.lightened(0.35)
var star_size = randf_range(0.95,1.45)
var star_radius = 0.0
var safeDisfromOthers: float = 0.0

@export var probability: float = 0.14

var star_affinities = {
	"Blue_Giant": 0.095,
	"BlackHole": 0.015,
	"Red_Giant": 0.03,
	"Neutron": 0.03,
	"White_Dwarf": 0.335,
	"Red_Dwarf": 0.19,
	"ProtoStar": 0.20,
	"Yellow_Star": 0.105
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_RedGiant()
	
func generate_RedGiant():
	#self.modulate = star_color

	var RedgiantSize = $Red_Giant.scale
	var RedgiantRad = $RedgiantRadius.shape.radius
	var RedgiantRadSize = $RedgiantRadius.scale
	
	RedgiantSize = Vector2(star_size,star_size)
	RedgiantRadSize = RedgiantSize * 2
	
	star_radius = RedgiantRadSize.length() * RedgiantRad
	safeDisfromOthers = star_radius * 3.75
