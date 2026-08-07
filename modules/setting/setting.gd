class_name Setting extends BaseModel

var _setting_data: SettingData = SettingData.new()

func _get_data(): return _setting_data
func _set_data(val): _setting_data = val

func _get_file_name()->String: return "setting"

func _init() -> void:
	pass

class SettingData extends BaseData:
	pass
