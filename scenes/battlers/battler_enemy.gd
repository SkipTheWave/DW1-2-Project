extends Battler
class_name BattlerEnemy

@onready var hp_bar = $VBox/HealthBar
@onready var anim_player = $AnimationPlayer
@onready var sprite = $VBox/Sprite
@onready var border = $VBox/Sprite/Border

var reward_xp : int
var reward_g : int

func _ready():
	super._ready()
	sprite.texture = stats_data.sprite_full
	
	hp_bar.max_value = max_hp
	update_display()
	
func update_display():
	hp_bar.value = curr_hp
	hp_bar.get_child(0).text = "%s/%s" % [curr_hp, max_hp]
	
func take_damage(dmg):
	super.take_damage(dmg)
	anim_player.play("hurt")
	update_display()
