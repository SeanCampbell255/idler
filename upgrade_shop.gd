extends Control

@onready var goopRate = $"Panel/Goop Rate"

var goopRateCost = 20


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	var goopRateChildren = goopRate.get_children()
	goopRateChildren[0].text = "Goop Rate"
	goopRateChildren[1].text = str(goopRateCost) + "Goops"
	goopRateChildren[1].disabled = true
	


func _on_close_pressed() -> void:
	visible = false


func _on_visibility_changed() -> void:
	if visible == true && get_parent().goops >= goopRateCost:
		goopRate.get_children()[1].disabled = false
		
