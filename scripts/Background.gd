extends TextureRect


onready var anim_player =  $AnimationPlayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	anim_player.play("LogoAnim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
#	pass
