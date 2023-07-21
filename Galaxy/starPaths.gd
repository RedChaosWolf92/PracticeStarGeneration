extends Node2D

var starPaths = {} # to store references to stars and their paths
const MAX_DISTANCE = 25000
const MIN_DISTANCE = 500
const MAX_ATTEMPT = 15

class StarComparator:
	var ref_star
	var refposition
	
	func _init(_ref_star):
		ref_star = _ref_star
		refposition = ref_star.global_position
		
	func compare(star1, star2):
		var dist1 = star1.global_position.distance_to(refposition)
		var dist2 = star2.global_position.distance_to(refposition)
		
		if dist1 < dist2:
			return -1
		elif dist1 > dist2:
			return 1
		else:
			return 0

func generate_paths():
	var all_stars = get_tree().get_nodes_in_group("stars")
	for star in all_stars:
		starPaths[star] = 0
		var max_paths = get_max_paths(star.star_type)
		for star_type in star.star_affinities.keys():
			if starPaths[star] < max_paths:
				add_path_between(star, all_stars, star_type)

	
func path_exists_between(star1, star2):
	for path in star1.get_node("StarPaths").get_children():
		if path.points[1] == star2.global_position:
			return true
	return false


func get_max_paths(star_type):
	match star_type:
		"BlackHole":
			return 1
		"Neutron":
			return 2
		"White_Dwarf":
			return 4
		"ProtoStar": 
			return 2
		"Red_Giant":
			return 4
		"Red_Dwarf":
			return 5
		"Blue_Giant":
			return 3
		"Yellow_Star":
			return 5
	
	return 0

func get_star_within_range(ref_star, all_stars, min_distance, max_distance):
	var current_max_distance = min_distance + 500
	while current_max_distance <= max_distance:
		for star in all_stars:
			var distance = star.global_position.distance_to(ref_star.global_position)
			if star != ref_star and distance >= min_distance and distance < max_distance:
				return star
		current_max_distance += 1500
	return null
	
func add_path_between(star1, all_stars, star_type):
	if starPaths[star1] >= get_max_paths(star1.star_type):
		return
		
	var star2 = get_star_within_range(star1,all_stars, star1.star_affinities[star_type], MAX_DISTANCE)
	if star2 == null or path_exists_between(star1, star2):
		return
	
	if not star1 in starPaths or not star2 in starPaths:
		print("Star not found in Dictionary!")
		return
		
		
	print("Star1 Position: ", star1.global_position)
	print("Star2 Position: ", star2.global_position)
	
	var line = Line2D.new()
	line.default_color = Color(randf(),randf(), 1)
	line.width = 5.0
	line.points = [star1.global_position, star2.global_position]
	
	get_parent().add_child(line)
	
	#increase path count for each star
	starPaths[star1] += 1
	starPaths[star2] += 1
