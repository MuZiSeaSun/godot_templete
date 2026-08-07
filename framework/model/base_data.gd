@abstract
class_name BaseData extends RefCounted

func _to_dict() -> Dictionary[String, Variant]:
	var proplist = self.get_property_list()
	var dict: Dictionary[String, Variant]
	for prop in proplist:
		match prop.type:
			TYPE_NIL: pass
			TYPE_OBJECT:
				var val = self.get(prop.name)
				if val is BaseData:
					dict[prop.name] = val._to_dict()
			_: dict[prop.name] = self.get(prop.name)
	return dict

func _from_dict(dict: Dictionary[String, Variant])->void:
	var proplist = self.get_property_list()
	for prop in proplist:
		var prop_name = prop.name
		if dict.has(prop_name):
			var prop_val = dict[prop_name]
			match prop.type:
				TYPE_NIL: pass
				TYPE_OBJECT:
					var val = self.get(prop_name)
					if val && val is BaseData:
						val._from_dict(prop_val as Dictionary[String, Variant])
				_:
					self.set(prop.name, prop_val)
