extends CanvasLayer

signal start_game

func show_message(text):
	$MessageLabel.text = text
	$MessageLabel.show()
	$MessageTimer.start()


func show_game_over():
	show_message("Game Over")
	await $MessageTimer.timeout
	$MessageLabel.text = "Dodge the\nCreeps"
	$MessageLabel.show()
	await get_tree().create_timer(1).timeout
	$ButtonsArea.show()


func update_score(score):
	$ScoreLabel.text = str(score)


func _on_StartButton_pressed():
	$ButtonsArea.hide()
	start_game.emit()


func _on_MessageTimer_timeout():
	$MessageLabel.hide()

func _on_start_client_button_pressed() -> void:
	$ButtonsArea.hide()
	$NameInput.show()
	$NameInput/ClientDiscovery._on_start_server_discovery()

func _on_name_commit_button_pressed() -> void:
	$NameInput.hide()

func _on_start_server_button_pressed() -> void:
	$ButtonsArea.hide()
	$LobbyArea.show()
	$LobbyArea/ServerDiscovery._on_start_server_discovery()

func _on_start_game_button_pressed() -> void:
	$LobbyArea.hide()
	start_game.emit()

func _on_name_input_changed(new_text: String) -> void:
	var regex = RegEx.new()
	regex.compile("^[a-zA-Z]{3,10}$")
	var result = regex.search(new_text)
	$NameInput/ConfirmNameButton.disabled = false if result else true
