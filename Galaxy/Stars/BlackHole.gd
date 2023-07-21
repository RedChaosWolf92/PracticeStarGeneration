extends StaticBody2D

var star_type = "BlackHole"
var star_size = randf_range(0.3,.6)
var star_radius = 0.0
var blackhole = Color.BLACK.lightened(0.1)
var border = Color.WHITE

@export var probability: float = 0.05
var safeDisfromOthers: float = 0.0

var star_affinities = {
	"Blue_Giant": .211,
	"BlackHole": 0.0,
	"Red_Giant": .211,
	"Neutron": .087,
	"White_Dwarf": .140,
	"Red_Dwarf": .140,
	"ProtoStar": .105,
	"Yellow_Star": .088
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_BlackHole()
	
func generate_BlackHole():
	self.modulate = blackhole
	var BlackHolesize = get_node("BlackHoleImage").scale
	var BlackHoleRad = $BlackHoleRadius.shape.radius
	var BlackHoleRadSize = $BlackHoleRadius.scale
	
	BlackHolesize = Vector2(star_size, star_size)
	
	BlackHoleRadSize = BlackHolesize * 4.0
	
	star_radius = BlackHoleRadSize.length() * BlackHoleRad
	safeDisfromOthers = star_radius * 5

