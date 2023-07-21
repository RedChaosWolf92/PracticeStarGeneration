extends StaticBody2D

var star_type = "Yellow_Star"
var star_size = randf_range(0.35,.075)
var star_radius = 0.0
var safeDisfromOthers: float = 0.0

@export var probability: float = 0.19

var star_affinities = {
	"Blue_Giant": 0.10,
	"BlackHole": 0.05,
	"Red_Giant": 0.15,
	"Neutron": 0.08,
	"White_Dwarf": 0.17,
	"Red_Dwarf": 0.25,
	"ProtoStar": 0.10,
	"Yellow_Star": 0.10
}

func _ready():
	randomize()
	generate_YellowStar()
	
func generate_YellowStar():
	var YellowstarSize = $Yellow_Star.scale
	var YellowstarRad = $YellowstarRadius.shape.radius
	var YellowstarRadSize = $YellowstarRadius.scale
	
	YellowstarSize = Vector2(star_size,star_size)
	YellowstarRadSize = YellowstarSize * 2
	
	star_radius = YellowstarRadSize.length() * YellowstarRad
	safeDisfromOthers = star_radius * 4
