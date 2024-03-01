extends Control

@onready var name_label = $VBoxOuter/Name
@onready var sprite = $VBoxOuter/MarginCont/VBoxInner/HBox/Panel/Sprite2D
@onready var hp_label = $VBoxOuter/MarginCont/VBoxInner/HBox/VBoxLabels/HpLabel
@onready var mp_label = $VBoxOuter/MarginCont/VBoxInner/HBox/VBoxLabels/MpLabel
@onready var lvl_label = $VBoxOuter/MarginCont/VBoxInner/HBox/VBoxLabels/LvlLabel

func setup(actor : BattlerActor):
	name_label.text = actor.display_name
	sprite.texture = actor.stats_data.sprite_actor
	update_display(actor.curr_hp, actor.curr_mp, actor.curr_level)
	
func update_display(hp, mp, lvl):
	hp_label.text = "Hp%4d" % hp
	mp_label.text = "Mp%4d" % mp
	lvl_label.text = "Lv:%3d" % lvl
