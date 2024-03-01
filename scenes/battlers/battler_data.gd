extends Resource
class_name BattlerData

enum Rank { F, E, D, C, B, A, S }
enum EquipSlot { WIELD, ARMOR, HEAD, ACCESSORY, NONE }
enum WieldType { WPN_GENERAL, WPN_HEAVY, WPN_MAGICAL, SHIELD, GREATSHIELD, NONE }

@export_category("Basic Properties")
@export var species_name : String
@export var creature_rank : Rank
@export var sprite_full : Texture2D
@export var sprite_timeline : Texture2D
@export var sprite_actor : Texture2D

@export_category("Equipment")
@export var equip_slot_A : EquipSlot
@export var equip_slot_B : EquipSlot
@export var equip_slot_C : EquipSlot
@export var equip_slot_D : EquipSlot
@export var equip_slot_E : EquipSlot
@export var forbidden_wield_A : WieldType
@export var forbidden_wield_B : WieldType

@export_category("Stats")
@export var lv1_hp : int
@export var lv99_hp : int
@export var lv1_mp : int
@export var lv99_mp : int
@export var lv1_strength : int
@export var lv99_strength : int
@export var lv1_magic_might : int
@export var lv99_magic_might : int
@export var lv1_magic_mend : int
@export var lv99_magic_mend : int
@export var lv1_resilience : int
@export var lv99_resilience : int
@export var lv1_agility : int
@export var lv99_agility : int
@export var lv1_deftness : int
@export var lv99_deftness : int
@export var lv1_charm : int
@export var lv99_charm : int

#var attack : int
#var defense : int
#var spell_defense : int
#var crit_chance : float
#var crit_dmg : float
#var evade_chance : float
#var block_chance : float
#var action_speed : float

@export_category("Elemental Stats")
@export var resistances := {
	"fire" : 1.0,
	"ice" : 1.0,
	"wind" : 1.0,
	"zap" : 1.0,
	"dark" : 1.0,
	"earth" : 1.0,
	
	"stun" : 1.0,
	"poison" : 1.0,
	"snooze" : 1.0,
	"paralysis" : 1.0,
	"whack" : 1.0,
	"fuddle" : 1.0,
	"dazzle" : 1.0,
	"fizzle" : 1.0,
	"charm" : 1.0,
	
	"defDown" : 1.0,
	"spellDefDown" : 1.0,
	"atkDown" : 1.0,
	"spdDown" : 1.0
}






