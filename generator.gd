extends Node2D

@onready var ignition = $Ignition
@onready var sprite = $Sprite
@onready var readout = $Readout
@onready var goopTimer = $"Goop Timer"
@onready var generatorTimer = $"Generator Timer"
@onready var goopRateLabel = $"Goop Rate"
@onready var upgradeButton = $"Upgrades"

var generatorMessages: Array[String]
var goops = 0
var goopRate = 1 # goops per second

# Initializing messages for generator start
func _ready() -> void:
	goopRateLabel.text = ""
	
	_on_generator_timer_timeout()

# Creates a 'start the generator' loop to be used when 'fuel' runs out
func restart_generator() -> void:
	if generatorMessages.is_empty():
		update_readout()
		goopTimer.start()
		generatorTimer.start()
		
		goopRate = 1
		goopRateLabel.text = str(goopRate) + "/sec"
		ignition.disabled = true
	else:
		readout.text = generatorMessages.pop_front()

func update_readout() -> void:
	readout.text = "[center]" + "Goops Gained: " + str(goops) + "[/center]"

# Increment resource and update text
func _on_goop_timer_timeout() -> void:
	goops+=1
	update_readout()


func _on_generator_timer_timeout() -> void:
	# Reset the dialogue for starting the generator
	generatorMessages.push_back("OwO noooo, the generator is out!")
	generatorMessages.push_back("Mmmm I wanna pull that ignition cord so good")
	generatorMessages.push_back("[i]Brrt...[/i]  Guess I'll try again?")
	generatorMessages.push_back("[i][b]BRRRRRRT[/b]..![/i] I think it'll start!")
	generatorMessages.push_back("[b]INSANE ONOMONOPIA[/b] Okay I'm gooping now :sunglasses:")
	
	# Sets things when "out of fuel", this could be handled with state?
	goopRate = 0
	goopRateLabel.text = str(goopRate) + "/sec"
	goopTimer.stop()
	restart_generator()
	ignition.disabled = false


func _on_ignition_pressed() -> void:
	restart_generator()
