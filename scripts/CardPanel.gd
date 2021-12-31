extends PanelContainer

class_name CardPanel

signal show_card
signal hide_card

onready var cardnode = get_node("CenterAligner/CardNode")
var FaceUp = false
var notvisible = Color(1, 1, 1, 0)
var isvisible = Color(1, 1, 1, 1)


#Constructor  -- Input is String Path to face up texture
#func _init(frontTexture := "res://assets/card_pack/front1b.png"):
#	texturePath = frontTexture

func _ready():
	pass


func get_front_texture():
	return cardnode.FrontTexture


func set_texture_to(texture: String, backtexture: String):
	cardnode.texture_path = texture
	cardnode.BackTexture = load(backtexture)
	cardnode.FrontTexture = load(texture)
	cardnode.set_texture(cardnode.BackTexture)


func dissolve():
	modulate = notvisible


func resolve():
	modulate = isvisible


func _on_CardNode_placed_face_down():
	emit_signal("hide_card")


func _on_CardNode_placed_face_up():
	emit_signal("show_card")


