class_name CMD extends RefCounted

var name: String
var function: Callable
var help: String
var args_type: Array[Variant.Type]

func _init(_name: String, _function: Callable, _args_type: Array[Variant.Type] = [], _help: String = "") -> void:
	if _function.get_argument_count() != _args_type.size(): 
		printerr("creat cmd args wrong, name: %s" % _name)
	name = _name
	function = _function
	args_type = _args_type
	help = _help

func excute(args: Array[Variant]):
	if !check_args(args): return
	return function.callv(args)

func excute_with_str(arg_strs: PackedStringArray):
	if arg_strs.size() != args_type.size(): 
		printerr("call cmd name: %s wrong args count %s" % [name, arg_strs])
		return
	var args: Array[Variant]
	for i in range(arg_strs.size()):
		var arg_str := arg_strs[i]
		var arg_type := args_type[i]
		var arg = StrUtil.safe_convert(arg_str, arg_type)
		args.push_back(arg)
	return excute(args)

func check_args(args: Array[Variant]) -> bool:
	if function.get_argument_count() != args.size(): 
		printerr("call cmd name: %s on wrong count need: %s count: %s. args: %s" % [name, args, function.get_argument_count(), args.size()])
		return false
	for i in range(args.size()):
		var arg = args[i]
		var arg_type := args_type[i]
		if arg_type != typeof(arg):
			printerr("call cmd name: %s on wrong arg: (index:%s need_type:%s type:%s). args: %s" % [name, i, type_string(arg_type), type_string(typeof(arg)), args, help])
			return false
	return true
