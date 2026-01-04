extends CanvasModulate

func _process(_delta):
	var progress = timer.get_day_progress()
	self.color = timer.gradientColor.sample(progress)
