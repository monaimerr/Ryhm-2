extends Path2D

@onready var day_progress_manager: Node = $"../DayProgressManager"
@onready var cosine_multiplier = randi_range(12,20)

# Loads the scene that is required to spawn new customers
@onready var customer_path_follow_scene = preload("res://scenes/entities/characters/NPCs/customer_path_follow.tscn")

# Loads all the spriteFrames that are used by customers
@onready var boo: SpriteFrames = preload("res://resources/sprite_frames/boo.tres")
@onready var grimmy: SpriteFrames = preload("res://resources/sprite_frames/grimmy.tres")
@onready var sheep_man: SpriteFrames = preload("res://resources/sprite_frames/sheep_man.tres")
@onready var shimmerling: SpriteFrames = preload("res://resources/sprite_frames/shimmerling.tres")
@onready var shroomary: SpriteFrames = preload("res://resources/sprite_frames/shroomary.tres")
@onready var tony: SpriteFrames = preload("res://resources/sprite_frames/tony.tres")
@onready var unexpected: SpriteFrames = preload("res://resources/sprite_frames/unexpected.tres")
@onready var sprite_frames = [boo, grimmy, sheep_man, shimmerling, shroomary, tony, unexpected]
@onready var sprite_frames_full = Array()

# Loads all potion requests
@onready var everything: PotionRequest = preload("res://resources/potion_requests/everything_request.tres")
@onready var healing: PotionRequest = preload("res://resources/potion_requests/healing_request.tres")
@onready var ill: PotionRequest = preload("res://resources/potion_requests/ill_intent_request.tres")
@onready var invisibility: PotionRequest = preload("res://resources/potion_requests/invisibility_request.tres")
@onready var love: PotionRequest = preload("res://resources/potion_requests/love_request.tres")
@onready var strength: PotionRequest = preload("res://resources/potion_requests/strength_request.tres")
@onready var potion_requests = [everything, healing, ill, invisibility, love, strength]

@export var max_customers = 3
var canSpawn = false

func _ready() -> void:
	sprite_frames_full = sprite_frames.duplicate()
	sprite_frames.shuffle()

# Instanciates a new customer if current customer count is less than max_customers and shop is open
func _on_customer_spawn_timer_timeout() -> void:
	if canSpawn and get_child_count() < max_customers:
		
		# Choosing randomly if customer is spawned or not
		if !should_spawn():
			print("should spawn = false")
			return
		
		var instance = customer_path_follow_scene.instantiate()
		
		# The customers appearance is picked randomly
		instance.get_node("Customer").spriteFrames = pick_random_sprite_frame()
		
		#The potion request is picked randomly with different a weight for each potion
		instance.get_node("Customer").potionRequest = pick_random_potion()
		
		add_child(instance)
		print(get_child_count())
		

func _on_open_sign_shop_opened_status_changed(shop_open: bool) -> void:
	canSpawn = shop_open
	
# Picks a random potion with different probabilities for each potion
func pick_random_potion():
	# Picks a float between 0 and 1
	var random_float = randf()
	
	if random_float < 0.15:
		# 15% chance of being returned.
		return love
	elif random_float < 0.30:
		# 15% chance of being returned.
		return ill
	elif random_float < 0.49:
		# 19% chance of being returned.
		return strength
	elif random_float < 0.71:
		# 22% chance of being returned.
		return invisibility
	elif random_float < 0.90:
		# 19% chance of being returned.
		return healing
	else:
		# 10% chance of being returned.
		return everything
	
# Uses the shuffle bag pattern to avoid having duplicates of the same customer in the shop
func pick_random_sprite_frame():
	if sprite_frames.is_empty():
		sprite_frames = sprite_frames_full.duplicate()
		sprite_frames_full.shuffle()
	return sprite_frames.pop_front()
	
func should_spawn():
	print("child count: ",get_child_count())
	var limit = 0.3 * cos(cosine_multiplier * day_progress_manager.get_day_progress()) + 0.65 - 0.15 * get_child_count()
	print(str("limit: ", limit))
	return randf() < limit
	
		
func _on_day_progress_manager_new_day_begun() -> void:
	cosine_multiplier = randi_range(12, 20)
	print("cosine_multiplier:", cosine_multiplier)
