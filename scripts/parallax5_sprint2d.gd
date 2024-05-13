extends Sprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta):
	queue_redraw()

func _draw():
	RenderingServer.canvas_item_add_texture_rect(get_canvas_item(), get_viewport_rect(), texture.get_rid(), true)
