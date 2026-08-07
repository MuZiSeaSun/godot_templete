@abstract
class_name BaseModel extends RefCounted

## 数据
var data: BaseData:
	get = _get_data,
	set = _set_data

@abstract
func _get_data()->BaseData

@abstract
func _set_data(val: BaseData)

## 文件名
var file_name: String:
	get = _get_file_name

@abstract
## 获取文件名
func _get_file_name()->String

@abstract
func _init() -> void
