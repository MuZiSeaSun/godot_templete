class_name SLUtil

const dir_path := "user://save/"

static func get_save_path(file_name: String)->String:
	return dir_path + file_name + ".save"

static func init()->void:
	DirAccess.make_dir_recursive_absolute(dir_path)

static func load(model: BaseModel)->void:
	var path := SLUtil.get_save_path(model.file_name)
	if FileAccess.file_exists(path):
		var bytes := FileAccess.get_file_as_bytes(path)
		var dict : Dictionary[String, Variant] = bytes_to_var(bytes)
		model.data._from_dict(dict)

static func save(model: BaseModel)->void:
	var path := SLUtil.get_save_path(model.file_name)
	var file := FileAccess.open(path, FileAccess.WRITE)
	var dict = model.data._to_dict()
	var bytes := var_to_bytes(dict)
	file.store_buffer(bytes)
