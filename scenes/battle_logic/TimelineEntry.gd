extends Node
class_name TimelineEntry

var battler : Battler
var action_value : int
var av_rng = 0.05

func setup(b, av):
	battler = b
	new_turn(av)
	
func new_turn(av):
	action_value = av - battler.action_speed * randf_range(1-av_rng, 1+av_rng)
	
