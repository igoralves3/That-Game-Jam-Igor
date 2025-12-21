extends Button


@export var tipoConstrucao: String = "None"


func _on_pressed() -> void:
	print('click')
	verifica()
	
	
func verifica():
	print(tipoConstrucao)
	print(Global.currentBuilding)
	match tipoConstrucao :
		"alojamento", "capela", "fazenda", "madeireira", "minas":
			Global.currentBuilding = tipoConstrucao
			
