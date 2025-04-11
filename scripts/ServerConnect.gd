extends Node

const NETWORK_BROADCAST_LAN_PORT = 8808
const GODOT_SERVER = "GODOT_SERVER"
var pp_udp = PacketPeerUDP.new()
var timer = 0

func _ready():
	set_process(false)
	pp_udp.set_broadcast_enabled(true)
	pp_udp.set_dest_address("255.255.255.255", NETWORK_BROADCAST_LAN_PORT)

func _on_start_server_discovery():
	print("Server: Starting server discovery...")	
	set_process(true)

func _on_stop_server_discovery():	
	set_process(false)

func _process(delta):
	timer += delta
	if timer >= 1:
		print("Server sending out packet")
		pp_udp.put_packet("GODOT_SERVER".to_utf8_buffer())
		timer = 0
