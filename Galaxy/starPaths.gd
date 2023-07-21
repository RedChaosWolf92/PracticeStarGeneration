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
		var nearby_stars = get_nearby_stars(star, all_stars)
		for i in range(min(max_paths,nearby_stars.size())):
			var other_star = nearby_stars[i]
			if not path_exists_between(star, other_star):
				add_path_between(star, other_star)

func get_nearby_stars(ref_star, all_stars):
	var nearby_stars = []
	for star in all_stars:
		var distance = star.global_position.distance_to(ref_star.global_position)
		if star != ref_star and distance <= MAX_DISTANCE and distance > MIN_DISTANCE:
			nearby_stars.append(star)
	if nearby_stars.size() ==0:
		nearby_stars.append(get_closest_star(ref_star, all_stars))

	var comparator = StarComparator.new(ref_star)
	nearby_stars.sort_custom(Callable(comparator, "compare"))
	
	return nearby_stars

func get_closest_star(ref_star, all_stars):
	var closest_star = null
	var min_distance = INF
	for star in all_stars:
		var distance = star.global_position.distance_to(ref_star.global_position)
		if star != ref_star and distance < min_distance:
			min_distance = distance
			closest_star = star
	return closest_star

	
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
	
func add_path_between(star1, star2):
	#check if stars are in the dictionary
	if star1 in starPaths and star2 in starPaths:
		#check if either star has reached their maxium path count
		if starPaths[star1] >= get_max_paths(star1.star_type) or starPaths[star2] >= get_max_paths(star2.star_type):
			return
	else:
		print("Star not found in Dictionary!")
		return
	
	#add a check for existing paths
	print("attempting to add a path between ", star1.name, " + ", star2.name)
	for path in star1.get_node("StarPaths").get_children():
		if path.points[1] == star2.global_position:
			print("Path already exists, returning...")
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
	
	#add the lines as a child to the StarPaths nodes of both stars
	#star1.get_node("StarPaths").add_child(line)
	#star2.get_node("StarPaths").add_child(line)
	
