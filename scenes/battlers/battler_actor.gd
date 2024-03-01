extends Battler
class_name BattlerActor

signal update_display(hp : int, mp : int, lvl : int)

#@export var display_name : String
var learned_skills = []
var curr_xp = 0
var xp_to_lvl : int


func get_display_name():
	return display_name
	
func take_damage(dmg):
	super.take_damage(dmg)
	update_display.emit(curr_hp, curr_mp, curr_level)
