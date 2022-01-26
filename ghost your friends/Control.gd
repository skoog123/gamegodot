extends Control

onready var text = get_parent().get_node("dialogue").dialogue_1

var neutral_expression = preload("res://Assets/maya.png")
var angry_expression = preload("res://Assets/mayamad.png")

var dialogue_index = 0 
var finished
var active

var position
var expression

func _ready():
	load_dialogue()
	
func _physics_process(_delta):
	if active:
		
		if Input.is_action_just_pressed("ui_accept"):
			if finished == true:
				load_dialogue()
			else:
				$Textbox/Tween.stop.all()
				$TextBox/RichTextLabel.percent_visible = 1
				finished = true
		
		if $TextBox/Label.text == "Maya":
			$maya.visible = true
			if position == "1":
				$maya.global_position = get_parent().get_node("1").position
			if position == "2":
				$maya.global_position = get_parent().get_node("2").position
			if position == "3":
				$maya.global_position = get_parent().get_node("3").position
			if position == "4":
				$maya.global_position = get_parent().get_node("4").position
			
			if expression == "Neutral":
				$maya.texture = neutral_expression
			else:
				$maya.texture = angry_expression



		if $TextBox/Label.text == "boss":
			$boss.visible = true
			if position == "1":
				$boss.global_position = get_parent().get_node("1").position
			if position == "2":
				$boss.global_position = get_parent().get_node("2").position
			if position == "3":
				$boss.global_position = get_parent().get_node("3").position
			if position == "4":
				$boss.global_position = get_parent().get_node("4").position

		if $Button.text == "":
			$Button.visible = false
		else:
			$Button.visible = true
		if $Button2.text == "":
			$Button2.visible = false
		else:
			$Button2.visible = true

func load_dialogue():
	if dialogue_index < text.size():
		active = true
		finished = false
		
		$TextBox.visible = true
		$TextBox/RichTextLabel.bbcode_text = text[dialogue_index]["Text"]
		$TextBox/Label.text = text[dialogue_index]["Name"]
		$Button.text = text[dialogue_index]["Choices"][0]
		$Button2.text = text[dialogue_index]["Choices"][1]
	
		
		position = text[dialogue_index]["Position"]
		expression = text[dialogue_index]["Expression"]
		
		$TextBox/RichTextLabel.percent_visible = 0
		$TextBox/Tween.interpolate_property(
			$TextBox/RichTextLabel, "percent_visible", 0, 1, 1.1,
			Tween.TRANS_LINEAR, Tween.EASE_IN_OUT
		)
		$TextBox/Tween.start()
	else:
		$TextBox.visible = false
		finished = true
		active = false
	dialogue_index += 1

func _on_Tween_tween_completed(_object, _key):
	finished = true


func _on_Button_pressed():
	if $Button.text == "k":
		$Button.text = ""
		$Button2.text = ""
		text = get_parent().get_node("dialogue").after_choice_1
		dialogue_index = 0
		load_dialogue()

func _on_Button2_pressed():
	if $Button2.text == "no friggin way dude":
		$Button.text = ""
		$Button2.text = ""
		text = get_parent().get_node("dialogue").after_choice_2
		dialogue_index = 0
		load_dialogue()
		get_tree().change_scene("res://scenes/world.tscn")


