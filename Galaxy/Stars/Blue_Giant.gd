extends StaticBody2D

var star_type = "Blue_Giant"
var star_color = Color.DEEP_SKY_BLUE
var star_size = randf_range(0.75,1.50)
var star_radius = 0.0
var safeDisfromOthers: float = 0.0

var star_affinities = {
	"Blue_Giant": .28,
	"BlackHole": 0.05,
	"Red_Giant": .22,
	"Neutron": .07,
	"White_Dwarf": .10,
	"Red_Dwarf": .12,
	"ProtoStar": .09,
	"Yellow_Star": .07
}

@export var probability: float = 0.12

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_BlueGiant()
	
func generate_BlueGiant():
	self.modulate = star_color
	var BluegiantSize = $Blue_Giant.scale
	var BluegiantRad = $BlueRadius.shape.radius
	var BluegiantRadSize = $BlueRadius.scale
	
	BluegiantSize = Vector2(star_size,star_size)
	BluegiantRadSize = BluegiantSize * 2
	
	star_radius = BluegiantRadSize.length() * BluegiantRad
	safeDisfromOthers = star_radius * 4.75 
