extends StaticBody2D

var star_type = "Neutron"
var star_size = randf_range(0.20,0.35)
var star_radius = 0.0
var safeDisfromOthers: float = 0.0

@export var probability: float = 0.09

var star_affinities = {
	"Blue_Giant": 0.05,
	"BlackHole": 0.20,
	"Red_Giant": 0.20,
	"Neutron": 0.05,
	"White_Dwarf": 0.15,
	"Red_Dwarf": 0.15,
	"ProtoStar": 0.125,
	"Yellow_Star": 0.125
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_Neutron()
	
func generate_Neutron():
	
	var NeutronSize = $Neutron.scale
	var NeutronRad = $NeutronRadius.shape.radius
	var NeutronRadSize = $NeutronRadius.scale
	
	NeutronSize = Vector2(star_size,star_size)
	NeutronRadSize = NeutronSize * 4
	
	star_radius = NeutronRadSize.length() * NeutronRad
	safeDisfromOthers = star_radius * 5
