extends Button


@export var tipoConstrucao: String = "None"


func _on_pressed() -> void:
	verifica()
	
	
func verifica():
	match tipoConstrucao :
		"alojamento", "capela", "fazenda", "madeireira", "minas":
			Global.currentBuilding = tipoConstrucao
			
