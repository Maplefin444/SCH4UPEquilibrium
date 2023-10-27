extends Node

@onready var h2o_bar = get_node("H2O")
@onready var co2_bar = get_node("CO2")
@onready var h2co3_bar = get_node("H2CO3")
var H2O_concentration = 1.0
var CO2_concentration = 1.0
var H2CO3_concentration = 0.0

const initial_H2O = 2.0
const initial_CO2 = 1.0
const initial_H2CO3 = 0.5

# this value is the base rate constant
const reverse_rate_constant = 0.03
# equilibrium const, is used to find other rate constant
const equilibrium_const = 2
# other rate constant, calculated from the other rate constant, using k_f/k_r = k_c
const forward_rate_constant = reverse_rate_constant * equilibrium_const

func _process(delta):
	# literally rate laws
	var forward_rate = H2O_concentration * CO2_concentration * forward_rate_constant
	var reverse_rate = H2CO3_concentration * reverse_rate_constant
	# update concentration using rate and delta
	var delta_concentration = forward_rate - reverse_rate
	H2O_concentration -= delta_concentration * delta
	CO2_concentration -= delta_concentration * delta
	H2CO3_concentration += delta_concentration * delta
	# make sure concentration is not negative
	H2O_concentration = max(0, H2O_concentration)
	CO2_concentration = max(0, CO2_concentration)
	H2CO3_concentration = max(0, H2CO3_concentration)
	
	# make sure concentration doesn't overflow bar
	H2O_concentration = min(10.0,H2O_concentration)
	CO2_concentration = min(10.0, CO2_concentration)
	H2CO3_concentration = min(10.0,H2CO3_concentration)
	# adjust values to fit in bar
	h2o_bar.value = H2O_concentration * 10
	co2_bar.value = CO2_concentration * 10
	h2co3_bar.value = H2CO3_concentration * 10

func _ready():
	H2O_concentration = initial_H2O
	CO2_concentration = initial_CO2
	H2CO3_concentration = initial_H2CO3

func _input(event):
	if Input.is_action_pressed("KEY_H"):
		H2O_concentration += 0.1
	if Input.is_action_pressed("KEY_J"):
		CO2_concentration += 0.1
	if Input.is_action_pressed("KEY_N"):
		H2O_concentration = max(0, H2O_concentration - 0.1)
	if Input.is_action_pressed("KEY_M"):
		CO2_concentration = max(0, CO2_concentration - 0.1)


