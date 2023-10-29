extends Node2D

var data
var read = 0;
var corrans = 5
var textglitch = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	data = JSON.parse_string(FileAccess.get_file_as_string("res://Game/MainGame/Data.json"))
	if(not data):
		assert("CAN'T READ FILE")

func _process(delta):
	if(data[read].type == "text"):
		if textglitch != 1:
			$TextLayout/Text.text = data[read].get("text")
		else:
			$TextLayout/Text.text = "HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP HELP"
		$TextLayout.visible = true
	else:
		$TextLayout.visible = false
	
	if(data[read].type == "quiz"):
		$QuestionLayout.visible = true
	else:
		$QuestionLayout.visible = false
	if(data[read].type == "title"):
		$TitleLayout.visible = true
	else:
		$TitleLayout.visible = false


func _on_next_button_pressed():
	if(len(data) != read+1):
		read+=1
	if(data[read].type == "text"):
		$TextLayout/Text.text = data[read].get("text")
		if data[read].get("glitch"):
			var type = data[read].get("glitch")
			if type == "1":
				await get_tree().create_timer(randi_range(2,5)).timeout
				$knocking.play()
			if type == "2":
				await get_tree().create_timer(randi_range(2,5)).timeout
				textglitch = 1
				await get_tree().create_timer(0.5).timeout
				textglitch = 0
			if type == "3":
				await get_tree().create_timer(randi_range(2,5)).timeout
				$cavenoise.play()

	
	if(data[read].type == "quiz"):
		$QuestionLayout/Text.text = data[read].get("text")
		corrans = int(data[read].get("correct"))
		$QuestionLayout/a.disabled = false;
		$QuestionLayout/b.disabled = false;
		$QuestionLayout/c.disabled = false;
		$QuestionLayout/d.disabled = false;
		$QuestionLayout/a.text = data[read].get("1")
		$QuestionLayout/b.text = data[read].get("2")
		$QuestionLayout/c.text = data[read].get("3")
		$QuestionLayout/d.text = data[read].get("4")
		$NextButton.visible = false
	if(data[read].type == "title"):
		$TitleLayout/Text.text = data[read].get("text")


func _on_a_pressed():
	if(corrans != 1): $QuestionLayout/a.disabled = true;
	else: $NextButton.visible = true


func _on_b_pressed():
	if(corrans != 2): $QuestionLayout/b.disabled = true;
	else: $NextButton.visible = true


func _on_c_pressed():
	if(corrans != 3): $QuestionLayout/c.disabled = true;
	else: $NextButton.visible = true


func _on_d_pressed():
	if(corrans != 4): $QuestionLayout/d.disabled = true;
	else: $NextButton.visible = true
