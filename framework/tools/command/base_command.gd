@abstract
class_name BaseCommand extends RefCounted

@abstract func _init(arg: BaseCommand) -> void

var arg: BaseCommandArg:
	get = _get_arg,
	set = _set_arg

@abstract func _get_arg()
@abstract func _set_arg(val)

@abstract func extcute()
@abstract func undo()
