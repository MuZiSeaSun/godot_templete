class_name GM extends RefCounted
static var inst := GM.new()
static func reset(): inst = GM.new()
func _init() -> void:
	_register_cmd(CMD.new("all_cmd", _all_cmd, [], "print all cmd"))
	_register_cmd(CMD.new("help", _help, [TYPE_STRING], "get cmd help"))

var cmds: Dictionary[String, CMD]

static func all_cmd(): return inst._all_cmd()
func _all_cmd():
	var cmd_names: PackedStringArray
	for cmd_name in cmds:
		cmd_names.append(cmd_name)
	return "\n".join(cmd_names)

static func excute_with_str(cmd_str: String): return inst._excute_with_str(cmd_str)
func _excute_with_str(cmd_str: String):
	var parts := cmd_str.split(' ', false)
	if parts.size() <= 0: printerr("cmd wrong: %s" % cmd_str); return

	var cmd_name := parts[0]
	parts.remove_at(0)
	
	if !cmds.has(cmd_name): printerr("can't find cmd name: %s" % cmd_name); return
	var cmd := cmds[cmd_name]
	
	return cmd.excute_with_str(parts)

static func excute(cmd_name: String, ...args): return inst._excutev(cmd_name, args)

func _excute(cmd_name: String, ...args):
	return _excutev(cmd_name, args)
	
func _excutev(cmd_name: String, args: Array[Variant]):
	if !cmds.has(cmd_name): printerr("can't find cmd name: %s" % cmd_name); return
	var cmd := cmds[cmd_name]
	return cmd.excute(args)

static func help(cmd_name: String) -> String: return inst._help(cmd_name)
func _help(cmd_name: String) -> String:
	if !cmds.has(cmd_name): printerr("can't find cmd name: %s" % cmd_name); return ""
	var cmd := cmds[cmd_name]
	return cmd.help

static func register_cmd(cmd: CMD): inst._register_cmd(cmd)
func _register_cmd(cmd: CMD):
	var cmd_name = cmd.name
	if cmds.has(cmd_name):
		printerr("already register cmd name: %s, it will be overwrite" % cmd_name)
	cmds[cmd_name] = cmd

static func register_cmds(cmd_arr: Array[CMD]): inst._register_cmds(cmd_arr)
func _register_cmds(cmd_arr: Array[CMD]):
	for cmd in cmd_arr: _register_cmd(cmd)
