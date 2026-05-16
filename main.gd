extends Node2D


# Pseudocódigo básico en Godot para tu algoritmo
var espectro

func _ready():
	# Obtener el analizador del Bus Master (Asumiendo que es el efecto 0)
	espectro = AudioServer.get_bus_effect_instance(0, 0)

func _process(delta):
	# Rango de frecuencias graves (batería)
	var magnitud_graves = espectro.get_magnitude_for_frequency_range(20, 200).length()
	if magnitud_graves > umbral_de_golpe:
		generar_nota_en_carril(1) # Llama a tu función para crear la nota que cae
