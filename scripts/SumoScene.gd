extends Spatial

var red_texture: Texture
var blue_texture: Texture

# Called when the node enters the scene tree for the first time.
func _ready():
	red_texture = preload("res://blender/sumo-red.png")
	blue_texture = preload("res://blender/sumo-blue.png")
	pass # Replace with function body.

func leap_start():
	$AnimationPlayer.play("LeapStart")
	
func leap_end():
	$AnimationPlayer.play("LeapEnd")
	
func pick_blue():
	set_texture(blue_texture)
	
func pick_red():
	set_texture(red_texture)
	
func set_texture(texture: Texture):
	var material = SpatialMaterial.new()
	material.albedo_texture = texture
	$Armature/Cube.set_surface_material(0, material)
