extends CanvasLayer
#TODO 
#Deal with buttons for all level types, i.e main menu, playable level, others?...

#Signal sent to SceneSwitcher when level changes.
#The parameter "level_name" can be set in the Inspector window
signal level_changed(level_name)

export (String) var level_name = "level"

#A Dictionary of parameters to share between levels
var level_parameters := {"difficulty" : "normal",
"card_deck" : ["res://assets/card_pack/front1a.png",
			   "res://assets/card_pack/front1b.png",
			   "res://assets/card_pack/front2a.png",
			   "res://assets/card_pack/front2b.png",
			   "res://assets/card_pack/front3a.png",
			   "res://assets/card_pack/front3b.png",
			   "res://assets/card_pack/front4a.png",
			   "res://assets/card_pack/front4b.png",
			   "res://assets/card_pack/front5a.png",
			   "res://assets/card_pack/front5b.png",
			   "res://assets/card_pack/front6a.png",
			   "res://assets/card_pack/front6b.png"],
"background" : "res://assets/card_pack/cardbackground.png"
}
#onready var change_scene_button = $ChangeSceneButton
var change_scene_button
var deck1_button_selected = load("res://assets/optionscreen/deck1button_selected.png")
var deck1_button = load("res://assets/optionscreen/deck1button.png")
var deck2_button_selected = load("res://assets/optionscreen/deck2button_selected.png")
var deck2_button = load("res://assets/optionscreen/deck2button.png")
var deck3_button = load("res://assets/optionscreen/deck3button.png")
var green_texture_button = load("res://assets/optionscreen/greenbutton.png")
var red_texture_button = load("res://assets/optionscreen/redbutton.png")


#-----------------------------------------------------------------------------
#Use this to create change_scene_buttons for each and every level
#Some levels may use strange and complex path structures due to proper layout
#------------------------------------------------------------------------------
func _ready():
	if level_name == "main":
		change_scene_button = $MainMenu/HBoxContainer/VBoxContainer/VBoxContainer/ChangeSceneButton
	elif level_name == "play":
		change_scene_button = $Table/EndGraphic/VBoxContainer/HBoxContainer/ChangeSceneButton
	elif level_name == "options":
		change_scene_button = $Background/CenterContainer/HBoxContainer/VBoxContainer2/BackButton
	elif level_name == "splash":
		change_scene_button = $Background/CenterContainer/VBoxContainer/CenterContainer/ChangeSceneButton
	else:
		change_scene_button = $ChangeSceneButton


#------------------------------------------------------------------------------
# This function transfers the level_parameters to the new level
# and updates the display of those parameters
#
#------------------------------------------------------------------------------
func load_level_parameters(new_level_parameters: Dictionary):
	level_parameters = new_level_parameters
	#if level_name =="main":
		#change_scene_button = $MainMenu/HBoxContainer/VBoxContainer/VBoxContainer/ChangeSceneButton
	if level_name == "play":
		var table = $Table
		#change_scene_button = $ChangeSceneButton
		table.card_deck = level_parameters.card_deck.duplicate(true)
		table.background = level_parameters.background
		table.set_table()
	#$ClickLabel.text = "Clicks: " + str(level_parameters.clicks)


#------------------------------------------------------------------------------
# Plays the LevelLoadedSound to indicate the level has loaded
# and enables the ChangeSceneButton
#
#------------------------------------------------------------------------------
func play_loaded_sound() -> void:
	$LevelLoadedSound.play()
	change_scene_button.disabled = false


#------------------------------------------------------------------------------
# This function simply frees the scene once the ChangeSceneButton 
# ButtonClickedSound finishes playing
#
#------------------------------------------------------------------------------
func clean_up():
	if $ButtonClickedSound.playing:
		yield($ButtonClickedSound, "finished")
	queue_free()


#------------------------------------------------------------------------------
# This function changes the scene when the ChangeSceneButton is pressed
# It plays a sound, disables the button, and emits a signal with the 
# current level_name to the SceneSwitcher and is passed to handle_level_changed
#
#------------------------------------------------------------------------------
func _on_ChangeSceneButton_pressed() -> void:
	$ButtonClickedSound.play()
	change_scene_button.disabled = true
	emit_signal("level_changed", level_name)


#------------------------------------------------------------------------------
# Simply adds 1 to the clicks every time the ClickButton is pressed
#
#------------------------------------------------------------------------------


func _on_MainMenuButton_pressed() -> void:
	$ButtonClickedSound.play()
	change_scene_button.disabled = true
	emit_signal("level_changed", "splash")


func _on_QuitButton_pressed() -> void:
	get_tree().notification(MainLoop.NOTIFICATION_WM_QUIT_REQUEST)


func _on_BackButton_pressed() -> void:
	$ButtonClickedSound.play()
	change_scene_button.disabled = true
	emit_signal("level_changed", "splash")


func _on_OptionsButton_pressed() -> void:
	$ButtonClickedSound.play()
	change_scene_button.disabled = true
	emit_signal("level_changed", "op")


func _on_CardDeck1Button_pressed() -> void:
	var card_deck_button1 = $Background/CenterContainer/HBoxContainer/VBoxContainer/CardDeck1Button
	var card_deck_button2 = $Background/CenterContainer/HBoxContainer/VBoxContainer/CardDeck2Button
	var card_deck_button3 = $Background/CenterContainer/HBoxContainer/VBoxContainer/CardDeck3Button
	level_parameters = {"difficulty" : "normal",
"card_deck" : ["res://assets/card_pack/front1a.png",
			   "res://assets/card_pack/front1b.png",
			   "res://assets/card_pack/front2a.png",
			   "res://assets/card_pack/front2b.png",
			   "res://assets/card_pack/front3a.png",
			   "res://assets/card_pack/front3b.png",
			   "res://assets/card_pack/front4a.png",
			   "res://assets/card_pack/front4b.png",
			   "res://assets/card_pack/front5a.png",
			   "res://assets/card_pack/front5b.png",
			   "res://assets/card_pack/front6a.png",
			   "res://assets/card_pack/front6b.png"],
"background" : "res://assets/card_pack/cardbackground.png"
}
	card_deck_button1.texture_normal = deck1_button_selected
	card_deck_button2.texture_normal = deck2_button
	card_deck_button3.texture_normal = deck3_button


func _on_CardDeck2Button_pressed() -> void:
	var card_deck_button1 = $Background/CenterContainer/HBoxContainer/VBoxContainer/CardDeck1Button
	var card_deck_button2 = $Background/CenterContainer/HBoxContainer/VBoxContainer/CardDeck2Button
	var card_deck_button3 = $Background/CenterContainer/HBoxContainer/VBoxContainer/CardDeck3Button
	level_parameters = {"difficulty" : "normal",
"card_deck" : ["res://assets/card_pack2/front1a.png",
			   "res://assets/card_pack2/front1b.png",
			   "res://assets/card_pack2/front2a.png",
			   "res://assets/card_pack2/front2b.png",
			   "res://assets/card_pack2/front3a.png",
			   "res://assets/card_pack2/front3b.png",
			   "res://assets/card_pack2/front4a.png",
			   "res://assets/card_pack2/front4b.png",
			   "res://assets/card_pack2/front5a.png",
			   "res://assets/card_pack2/front5b.png",
			   "res://assets/card_pack2/front6a.png",
			   "res://assets/card_pack2/front6b.png"],
"background" : "res://assets/card_pack2/cardbackground.png"
}
	card_deck_button1.texture_normal = deck1_button
	card_deck_button2.texture_normal = deck2_button_selected
	card_deck_button3.texture_normal = deck3_button
