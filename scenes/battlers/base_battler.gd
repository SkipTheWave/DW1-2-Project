extends Node
class_name Battler

const BASE_MAX_LVL := 20
const MAX_MAX_LVL := 99
const MAX_LVL_PER_FUSION_LVL := 5
const MAX_ACTION_SPEED := 100

@export var stats_data : BattlerData
@export var display_name : String

# basic stats
@export var curr_level := 2
var max_level : int
var fusion_level : int
var curr_hp : int
var max_hp : int
var curr_mp : int
var max_mp : int
var strength : int
var resilience : int
var agility : int
var deftness : int
var charm : int
var magic_might : int
var magic_mend : int

# secondary stats
var attack : int
var defense : int
var spell_defense : int
var action_speed : int
var crit_chance : float
var crit_dmg : float
var evade_chance : float
var block_chance : float

var skills_available = []
var spells_available = []

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_setup()
	
func get_display_name():
	return display_name
	
func take_damage(dmg : int):
	curr_hp = max(0, curr_hp - dmg)
	
func load_base_stats():
	max_level = min(BASE_MAX_LVL + fusion_level * MAX_LVL_PER_FUSION_LVL, MAX_MAX_LVL)
	max_hp = calc_base_stat(stats_data.lv1_hp, stats_data.lv99_hp)
	max_mp = calc_base_stat(stats_data.lv1_mp, stats_data.lv99_mp)
	strength = calc_base_stat(stats_data.lv1_strength, stats_data.lv99_strength)
	resilience = calc_base_stat(stats_data.lv1_resilience, stats_data.lv99_resilience)
	agility = calc_base_stat(stats_data.lv1_agility, stats_data.lv99_agility)
	deftness = calc_base_stat(stats_data.lv1_deftness, stats_data.lv99_deftness)
	charm = calc_base_stat(stats_data.lv1_charm, stats_data.lv99_charm)
	magic_might = calc_base_stat(stats_data.lv1_magic_might, stats_data.lv99_magic_might)
	magic_mend = calc_base_stat(stats_data.lv1_magic_mend, stats_data.lv99_magic_mend)
	
	
func load_secondary_stats():
	# TODO do calcs with equips
	attack = strength
	defense = resilience
	spell_defense = resilience * 0.5
	# Base delay = 150
	#action_speed = MAX_ACTION_SPEED * (1.0 - exp(-0.005 * agility))
	action_speed = max(0, round(20.0 * log(0.5 * agility)))
	crit_chance = min(0.02 + deftness / 2000.0, 1.0)
	crit_dmg = 1.0 + deftness / 400.0
	# evasion doubled when attacked by lower agility battlers
	evade_chance = min(0.01 + agility / 2500.0, 1.0)
	# pretty much entirely dependent on shield
	block_chance = 0
	
func initial_setup():
	load_base_stats()
	load_secondary_stats()
	curr_hp = max_hp
	curr_mp = max_mp
	
func calc_base_stat(lv1_stat, lv99_stat):
	return round(lv99_stat / MAX_MAX_LVL * curr_level + lv1_stat)

