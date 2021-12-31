extends Node

var next_level = null

onready var current_level = $SplashLevel
onready var anim = $AnimationPlayer


#------------------------------------------------------------------------------
# The _ready function connects the signal "level_changed"
#
# It also plays a sound to indicate it is loaded.
#
#------------------------------------------------------------------------------

func _ready():
	randomize()
	current_level.connect("level_changed", self, "handle_level_changed")
	current_level.play_loaded_sound()


#------------------------------------------------------------------------------
#This function handles the logic for changing levels
#
# current_level_name is a String which comes from 
# level_name in the Level.gd script
# it can be hard coded or modified in the properties window of the 
# Level node
#
#------------------------------------------------------------------------------

func handle_level_changed(current_level_name: String):
	var next_level_name: String
	
	match current_level_name:
		"play":
			next_level_name = "Play"          #Currently only 1 level to play
		"main":
			next_level_name = "Play"
		"splash":
			next_level_name = "Main"
		"op":
			next_level_name = "Option"
		_:
			return
	
	next_level = load("res://change_scenes/" + next_level_name + "Level.tscn").instance()
	next_level.layer = -1
	add_child(next_level)
	anim.play("fade_in")
	next_level.connect("level_changed", self, "handle_level_changed")
	transfer_data_between_scenes(current_level, next_level)


#------------------------------------------------------------------------------
# This function transfers level_parameters between levels
#
# old_scene and new_scene are references to nodes for the 
# current_level and next_level
#
#------------------------------------------------------------------------------
func transfer_data_between_scenes(old_scene, new_scene):
	new_scene.load_level_parameters(old_scene.level_parameters)


#------------------------------------------------------------------------------
# This function holds the logic for what happens after each animation finishes
# 
#   anim_name is a String in the call 
#       "anim.play(anim_name)"
#       currently : "fade_in" 
#                   "fade_out"
#
#------------------------------------------------------------------------------

func _on_AnimationPlayer_animation_finished(anim_name: String) -> void:
	match anim_name:
		"fade_in":
			current_level.clean_up()
			current_level = next_level
			current_level.layer = 1
			next_level = null
			anim.play("fade_out")
		"fade_out":
			current_level.play_loaded_sound()
			
