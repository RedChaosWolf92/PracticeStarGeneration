extends Node2D

var starPaths = {} # to store references to stars and their paths
const MAX_DISTANCE = 15000
const MIN_DISTANCE = 250
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
	var connectable_stars = all_stars.duplicate()
	print("Found ", len(all_stars), "Stars")
	for star in all_stars:
		starPaths[star] = 0
		
	var attempts = 0
	while attempts < MAX_ATTEMPT and len(connectable_stars) > 0:
		var all_connected = true
		print("attempt #: ", attempts)
		for star in connectable_stars:
			if starPaths[star] == 0:
				all_connected = false
				print("Star with n0 paths: ", star.name)
				
				if not add_path_between(star,connectable_stars):
					print("Failed to add path for ", star.name)
					break
					
		if all_connected:
			break
		else:
			attempts += 1
		
	print("Final star paths: ", starPaths)

func path_exists_between(star1, star2):
	for path in star1.get_node("StarPaths").get_children():
		if path.points[1] == star2.global_position:
			return true
	return false

func add_path_between(star1, all_stars):
	if starPaths[star1] >= get_max_paths(star1.star_type):
		print("Star removed ", star1.name)
		all_stars.erase(star1)
		return false
		
	var sorted_stars = all_stars.duplicate()
	sorted_stars.sort_custom(Callable(StarComparator.new(star1), "compare"))
	for star_type in star1.star_affinities.keys():
		if starPaths[star1] >= get_max_paths(star1.star_type):
			continue
		for star2 in sorted_stars:
			if star2.star_type != star_type or path_exists_between(star1, star2):
				continue
				
			if star1 in starPaths and star2 in starPaths:	
				if starPaths[star1] >= get_max_paths(star1.star_type) or starPaths[star2] >= get_max_paths(star2.star_type):
					continue
			
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

