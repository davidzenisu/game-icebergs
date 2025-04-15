extends Node

var peer := WebRTCPeerConnection.new()
var multiplayer_peer := WebRTCMultiplayerPeer.new()

func _ready() -> void:
	var config := {
		"iceServers": []  # No STUN/TURN for LAN
	}
	peer.initialize(config)

	# Connect signals using Godot 4 syntax
	peer.session_description_created.connect(_on_sdp_created)
	peer.ice_candidate_created.connect(_on_ice_candidate)
	peer.connection_state_changed.connect(_on_connection_state_changed)

	# Create the offer
	peer.create_offer()

func _on_sdp_created(type: String, sdp: String) -> void:
	print("🔼 Send this OFFER to the client:\n", sdp)

func _on_ice_candidate(mid_name: String, index: int, sdp: String) -> void:
	print("🔼 Send this ICE candidate to the client:\n", sdp)

func _on_connection_state_changed(new_state: String) -> void:
	print("📡 Connection state:", new_state)
	if new_state == "connected":
		multiplayer_peer.add_peer(peer, 1)
		multiplayer.multiplayer_peer = multiplayer_peer
		print("🎉 Host connected to client!")

# Call these manually when you receive data from the client
func receive_answer(sdp: String) -> void:
	peer.set_remote_description("answer", sdp)

func add_remote_ice(candidate: String, sdp_m_line_index: int = 0) -> void:
	peer.add_ice_candidate("0", sdp_m_line_index, candidate)
