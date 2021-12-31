extends MarginContainer

onready var Card = [$VBoxContainer/Row1/Card1,
$VBoxContainer/Row1/Card2,
$VBoxContainer/Row1/Card3,
$VBoxContainer/Row1/Card4,
$VBoxContainer/Row2/Card5,
$VBoxContainer/Row2/Card6,
$VBoxContainer/Row2/Card7,
$VBoxContainer/Row2/Card8,
$VBoxContainer/Row3/Card9,
$VBoxContainer/Row3/Card10,
$VBoxContainer/Row3/Card11,
$VBoxContainer/Row3/Card12]

onready var end_graphic = $EndGraphic
onready var surprise_image = $SurpriseImage
#Try to pull this up to the Level node ( 1 node up)


var card_deck = []
var background
var pairs = {}
var matching_key = []
var flipped_card = null
var faceup_cards = 0
var back_image    # loaded img resource
var rand_img = ["res://assets/playscreen/backgrounds/background1.png",
				"res://assets/playscreen/backgrounds/background2.png",
				"res://assets/playscreen/backgrounds/background3.png",
				"res://assets/playscreen/backgrounds/background4.png",
				"res://assets/playscreen/backgrounds/background5.png",
				"res://assets/playscreen/backgrounds/background6.png",
				"res://assets/playscreen/backgrounds/background7.png",
				"res://assets/playscreen/backgrounds/background8.png",
				]
#var change_scene_button


func _ready():
	
	pass


#------------------------------------------------------------------------------
# Shuffles the cards and applies the textures of the card pack
# 
#------------------------------------------------------------------------------



func set_table():
	pairs = {card_deck[0] : card_deck[1],         # Builds a data structure (Dictionary)
			 card_deck[2] : card_deck[3],         # Where every card path lookup
			 card_deck[4] : card_deck[5],         # gives the corresponding matching
			 card_deck[6] : card_deck[7],         # card path, regardles of the card
			 card_deck[8] : card_deck[9],         # deck used.
			 card_deck[10] : card_deck[11],
			 card_deck[1] : card_deck[0],
			 card_deck[3] : card_deck[2],
			 card_deck[5] : card_deck[4],
			 card_deck[7] : card_deck[6],
			 card_deck[9] : card_deck[8],
			 card_deck[11] : card_deck[10]}
	
	rand_img.shuffle()
	back_image = load (rand_img[2])
	surprise_image.set_texture(back_image)
	
	card_deck.shuffle()                                           # Shuffles the cards
	for i in Card.size():
		Card[i].set_texture_to(card_deck[i], background)                    # Applies Textures
		matching_key.append(card_deck[i])                         # And builds matching_key array
																				   # with the texture paths in shuffle
																				   # order. 
																				   # Use : pairs.get(matching_key[int]


#Function that tests whether the cards match per the matching_key
func check_for_match(card1 : int, card2 : int):
	var the_match_card = pairs.get(matching_key[card1])                            # The match_card should be == card2
	var card2_texture_path = Card[card2].cardnode.texture_path                               # texture_path, if it is a match
	if card2_texture_path == the_match_card:
		match_pair(card1, card2)
	else:
		no_match_pair(card1, card2)


#Boolean function which returns if the table is cleared or not
func table_cleared() -> bool:
	for i in Card.size():
		if Card[i].modulate == Color(1, 1, 1, 1):
			return false
	return true


#function to remove matching pair of cards
func match_pair(card1 : int, card2 : int):
	#print("We have a match")
	Card[card1].dissolve()
	Card[card2].dissolve()
	if table_cleared():
		#print ("Table Cleared")
		yield(get_tree().create_timer(1.0), "timeout")
		end_graphic.visible = true
		


#Function that turns non matching cards back over
func no_match_pair(card1 : int, card2 : int):
	#print ("WTF Batman")
	Card[card1].cardnode.flip()
	Card[card2].cardnode.flip()


#Function to check if 2 cards are face up
func check_for_pair(current_card = 0):         
	faceup_cards = faceup_cards + 1
	if faceup_cards > 2:                         #If this is the 3rd card
		faceup_cards = 2                         #Disallow Shouldn't be able to get here
		return
	if flipped_card != null && faceup_cards == 2:      #If 2 cards, check match
		Card[current_card].cardnode.flip()             # Show second card
		for x in Card:                                 # Locks further input if
			x.cardnode.locked = true                   # 2 cards are faceup
		
		yield(get_tree().create_timer(1.0), "timeout")   #Delay to success or failure
		
		check_for_match(current_card, flipped_card)    #Determines if there is a match

		flipped_card = null                            #Reset the pair
		faceup_cards = 0
		for x in Card:
			x.cardnode.locked = false
		# re enable card input
	else:
		Card[current_card].cardnode.flip()    #First Card flips faceup
		flipped_card = current_card        #current_card becomes flipped_card
			




func _on_Card1_hide_card():
	#Card[0].set_texture_to(level_parameters.background)
	pass

func _on_Card1_show_card():
	check_for_pair(0)
	pass

func _on_Card2_hide_card():
	#Card[1].set_texture_to(level_parameters.background)
	pass

func _on_Card2_show_card():
	check_for_pair(1)
	pass

func _on_Card3_hide_card():
	#Card[2].set_texture_to(level_parameters.background)
	pass

func _on_Card3_show_card():
	check_for_pair(2)
	pass

func _on_Card4_hide_card():
	#Card[3].set_texture_to(level_parameters.background)
	pass

func _on_Card4_show_card():
	check_for_pair(3)
	pass

func _on_Card5_hide_card():
	#Card[4].set_texture_to(level_parameters.background)
	pass

func _on_Card5_show_card():
	check_for_pair(4)
	pass

func _on_Card6_hide_card():
	#Card[5].set_texture_to(level_parameters.background)
	pass

func _on_Card6_show_card():
	check_for_pair(5)
	pass

func _on_Card7_hide_card():
	#Card[6].set_texture_to(level_parameters.background)
	pass

func _on_Card7_show_card():
	check_for_pair(6)
	pass

func _on_Card8_hide_card():
	#Card[7].set_texture_to(level_parameters.background)
	pass

func _on_Card8_show_card():
	check_for_pair(7)
	pass

func _on_Card9_hide_card():
	#Card[8].set_texture_to(level_parameters.background)
	pass

func _on_Card9_show_card():
	check_for_pair(8)
	pass

func _on_Card10_hide_card():
	#Card[9].set_texture_to(level_parameters.background)
	pass

func _on_Card10_show_card():
	check_for_pair(9)
	pass

func _on_Card11_hide_card():
	#Card[10].set_texture_to(level_parameters.background)
	pass

func _on_Card11_show_card():
	check_for_pair(10)
	pass

func _on_Card12_hide_card():
	#Card[11].set_texture_to(level_parameters.background)
	pass

func _on_Card12_show_card():
	check_for_pair(11)
	pass


#On Retry, the Cards reappear in their previous position
func _on_RetryButton_pressed() -> void:
	for card in Card:
		card.cardnode.flip()
		card.resolve()
	end_graphic.visible = false
