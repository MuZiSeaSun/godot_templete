class_name StrUtil

static func safe_to_bool(string: String) -> bool:
	if string.matchn("true"): return true
	elif string.matchn("false"): return false
	elif string.is_valid_int():
		var n := string.to_int()
		return true if n != 0 else false
	elif string.is_valid_float():
		var f := string.to_float()
		return true if f != 0.0 else false
	elif string.is_valid_hex_number():
		var f := string.hex_to_int()
		return true if f != 0.0 else false
	else:
		push_warning("Invalid convert (string: %s) to bool" % string)
		return false

static func safe_to_int(string: String) -> int:
	string = string.remove_char(ord('_'))
	string = string.remove_char(ord(','))
	string = string.remove_char(ord(' '))
	if string.is_valid_int():
		return string.to_int()
	elif string.is_valid_hex_number() || string.is_valid_hex_number(true):
		return string.hex_to_int()
	else:
		push_warning("Invalid convert (string: %s) to int" % string)
		return 0

static func safe_to_float(string: String) -> float:
	string = string.remove_char(ord('_'))
	string = string.remove_char(ord(','))
	string = string.remove_char(ord(' '))
	if string.is_valid_float():
		return string.to_float()
	else:
		push_warning("Invalid convert (string: %s) to float" % string)
		return 0

static func safe_convert(string: String, type: Variant.Type) -> Variant:
	match type:
		TYPE_BOOL:
			return safe_to_bool(string)
		TYPE_INT:
			return safe_to_int(string)
		TYPE_FLOAT:
			return safe_to_float(string)
		TYPE_STRING:
			return string
		## TODO: Vector2 ...
		_:
			push_error("Invalid type for convert type: %s, string: %s" % [type_string(type), string])
			return type_convert(string, type)
