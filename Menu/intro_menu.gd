extends Node2D
signal buttonpress

var textlines = [
"IDM Personal Computer BOS Version 3.30\n",
"Please Insert Disk.\n",
"ins",
"cls",
"1440 KB\n",
"The disk appears to be corrupted. Attempt to repair?\n",
"Please enter Y or N\n",
"inp",
"Attempting to repair...\n",
"cls",
"The disk is functional.\n",
"Running software.exe...\n",
"end"
]
# Called when the node enters the scene tree for the first time.
func _ready():
	await get_tree().create_timer(18).timeout
	for i in textlines:
		await get_tree().create_timer(0.30).timeout
		if i == "cls":
			await clear()
		elif i == "ins":
			await insert()
		elif i == "inp":
			await buttonpress
		else:
			await add_text(i)
		

func add_text(text):
	for i in range(len(text)):
		$ConsoleText.text += text[i]
		await get_tree().create_timer(0.05).timeout

func clear():
	$ConsoleText.text = ""

func insert():
	$insertdisk.play(0)
	await $insertdisk.finished

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _input(event):
	buttonpress.emit()
