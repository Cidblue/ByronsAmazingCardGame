extends TextureRect

#-------------------------Input--------------------------------
#         String : the file location for the Card front
#                          texture
#        Ex:  "res://assets/card_pack/front1a.png"
#--------------------------------------------------------------

signal placed_face_down
signal placed_face_up

var texture_path : String
var FrontTexture = null
var BackTexture = null
var MouseInBounds = false
var faceup = false
var locked = false

#Constructor
#func _init(frontTexture := "res://assets/card_pack/front1a.png"):
#	FrontTexture = load(frontTexture)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


#This function flips the card when clicked by the mouse (Either button)
func _input(event):
	#print(event.as_text())
	if event is InputEventMouseButton && MouseInBounds && !locked:
		if event.is_pressed():
			emit_event()
			get_tree().set_input_as_handled()


func get_texture():
	return str(FrontTexture)

func emit_event():
	if faceup:
		emit_signal("placed_face_down")
	else:
		emit_signal("placed_face_up")


func flip():
	if faceup:
		set_texture(BackTexture)
		faceup = false
	else: 
		set_texture(FrontTexture)
		faceup = true


#This keeps track of whether the mouse is over the card
func _on_CardNode_mouse_entered():
	MouseInBounds = true
	

#The complement to the above function
func _on_CardNode_mouse_exited():
	MouseInBounds = false

