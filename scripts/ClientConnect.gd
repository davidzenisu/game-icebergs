
extends Node

const NETWORK_BROADCAST_LAN_PORT = 8808
const GODOT_SERVER = "GODOT_SERVER"
var pp_udp = PacketPeerUDP.new()
var timer = 0

func _ready():
	set_process(false)
	pp_udp.bind(NETWORK_BROADCAST_LAN_PORT)  # Listen on the same port

func _on_start_server_discovery():
	print("Client: Starting server discovery...")	
	set_process(true)

func _on_stop_server_discovery():	
	set_process(false)

func _process(delta):
	timer += delta
	if timer >= 1:
		timer = 0
		print("Client looking for packet")
		if pp_udp.get_available_packet_count() > 0:
			var packet = pp_udp.get_packet()
			var packet_info = packet.get_string_from_utf8()
			print("Received packet from server:", packet_info)
			if packet_info == GODOT_SERVER:
				var server_ip = pp_udp.get_packet_ip()
				print("Server found at:", server_ip)
	
