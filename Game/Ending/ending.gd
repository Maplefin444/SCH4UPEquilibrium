extends Node2D
signal buttonpress

var textlines = [
"CRITICAL ERROR\n",
"The disk cannot be read.\n",
"wait",
"cls",
"Thank you for playing.\nThis project was made by:\nJames & Sharmin"
]
# Called when the node enters the scene tree for the first time.
func _ready():
	for i in textlines:
		await get_tree().create_timer(0.30).timeout
		if i == "cls":
			await clear()
		elif i == "inp":
			await buttonpress
		elif i == "wait":
			await get_tree().create_timer(5).timeout
		else:
			await add_text(i)

func add_text(text):
	for i in range(len(text)):
		$ConsoleText.text += text[i]
		await get_tree().create_timer(0.05).timeout

func clear():
	$ConsoleText.text = ""

func _input(event):
	buttonpress.emit()
