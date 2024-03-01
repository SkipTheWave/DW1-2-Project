extends Resource
class_name BattleAction

enum ActionType {
	BASIC, SKILL, SPELL
}

enum TargetType {
	SELF, ALLY_SINGLE, ALLY_ALL, ENEMY_SINGLE, ENEMY_ALL, ENEMY_GROUP
}

@export var display_name : String
@export var action_type : ActionType
@export var target_type : TargetType
@export var mp_cost : int

func execute(targets):
	pass
