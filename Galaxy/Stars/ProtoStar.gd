extends StaticBody2D

var star_type = "ProtoStar"
var star_size = randf_range(0.3,.6)
var star_radius = 0.0
var safeDisfromOthers: float = 0.0

@export var probability: float = 0.10

var star_affinities = {
	"Blue_Giant": 0.25,  
	"BlackHole": 0.025,  
	"Red_Giant": 0.25,  
	"Neutron": 0.075,  
	"White_Dwarf": 0.16,  
	"Red_Dwarf": 0.135,  
	"ProtoStar": 0.03, 
	"Yellow_Star": 0.075  
}

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	generate_ProtoStar()
	
func generate_ProtoStar():
	
	var ProtoSize = $ProtoStar.scale
	var ProtoRad = $ProtoRadius.shape.radius
	var ProtoRadSize = $ProtoRadius.scale
	
	ProtoSize = Vector2(star_size,star_size)
	ProtoRadSize = ProtoSize * 2
	
	star_radius = ProtoRadSize.length() * ProtoRad
	safeDisfromOthers = star_radius * 4.25
