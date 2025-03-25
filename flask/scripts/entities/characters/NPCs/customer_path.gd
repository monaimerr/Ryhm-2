extends Path2D

# Loads the scene that is required to spawn new customers
@onready var customer_path_follow_scene = preload("res://scenes/entities/characters/NPCs/customer_path_follow.tscn")

# Loads all the spriteFrames that are used by customers
@onready var boo = preload("res://resources/sprite_frames/boo.tres")
@onready var grimmy = preload("res://resources/sprite_frames/grimmy.tres")
@onready var sheep_man = preload("res://resources/sprite_frames/sheep_man.tres")
@onready var shimmerling = preload("res://resources/sprite_frames/shimmerling.tres")
@onready var shroomary = preload("res://resources/sprite_frames/shroomary.tres")
@onready var tony = preload("res://resources/sprite_frames/tony.tres")
@onready var unexpected = preload("res://resources/sprite_frames/unexpected.tres")

@onready var sprite_frames = [boo, grimmy, sheep_man, shimmerling, shroomary, tony, unexpected]

# Loads all potion requests
@onready var everything = preload("res://resources/potion_requests/everything.tres")
@onready var healing = preload("res://resources/potion_requests/healing.tres")
@onready var ill = preload("res://resources/potion_requests/ill_intent.tres")
@onready var invisibility = preload("res://resources/potion_requests/invisibility.tres")
@onready var love = preload("res://resources/potion_requests/love.tres")
@onready var strength = preload("res://resources/potion_requests/strength.tres")

@onready var potion_requests = [everything, healing, ill, invisibility, love, strength]


@export var max_customers = 3
var canSpawn = false

# Instanciates a new customer if current customer count is less than max_customers and shop is open
func _on_customer_spawn_timer_timeout() -> void:
	if canSpawn and get_child_count() < max_customers:
		var instance = customer_path_follow_scene.instantiate()
		instance.get_node("Customer").spriteFrames = sprite_frames.pick_random()
		instance.get_node("Customer").potionRequest = potion_requests.pick_random() # no way to check if plyer has right potion!
		add_child(instance)
		print(get_child_count())
		

func _on_open_sign_shop_opened_status_changed(shop_open: bool) -> void:
	canSpawn = shop_open
