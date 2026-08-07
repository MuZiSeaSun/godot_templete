# meta-description: Base template for Node with default Godot cycle methods

class_name _CLASS_ extends BaseModel

var __CLASS_SNAKE_CASE__data: _CLASS_Data = _CLASS_Data.new()

func _get_data(): return __CLASS_SNAKE_CASE__data
func _set_data(val): __CLASS_SNAKE_CASE__data = val

func _get_file_name()->String: return "_CLASS_SNAKE_CASE_"

func _init() -> void:
	pass

class _CLASS_Data extends BaseData:
	pass
