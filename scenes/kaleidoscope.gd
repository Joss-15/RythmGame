extends ColorRect

const BASE_INTENSITY: float = 0.15 

var intensities: Array[float] = [BASE_INTENSITY, BASE_INTENSITY, BASE_INTENSITY, BASE_INTENSITY, BASE_INTENSITY, BASE_INTENSITY]
var is_miss: Array[float]     = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

var _beat_tween: Tween = null 
var _shake_tween: Tween = null # Controlador exclusivo para la vibración
var _base_pos: Vector2 = Vector2.ZERO

func _ready() -> void:
	material.set_shader_parameter("intensities", intensities)
	material.set_shader_parameter("is_miss", is_miss)
	
	pivot_offset = size / 2.0
	
	# Guardamos la posición original (X: 0, Y: 220) para que la vibración sepa a dónde regresar
	_base_pos = position

# ── 1. Estallido brillante al atinar (Hit) + LATIDO GLOBAL ──
func flash_hit(lane: int) -> void:
	_set_miss(0.0, lane) 
	var tw = create_tween()
	tw.tween_method(_set_intensity.bind(lane), 3.0, BASE_INTENSITY, 0.35).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)

	if _beat_tween and _beat_tween.is_valid():
		_beat_tween.kill()
		
	_beat_tween = create_tween()
	scale = Vector2(1.06, 1.06) 
	_beat_tween.tween_property(self, "scale", Vector2(1.0, 1.0), 0.25).set_trans(Tween.TRANS_BACK).set_ease(Tween.EASE_OUT)

# ── 2. Estallido rojo por fallar (Miss) + VIBRACIÓN (SHAKE) ──
func flash_miss(lane: int) -> void:
	_set_miss(1.0, lane) 
	
	# 1. Animación de luz roja del carril
	var tw = create_tween()
	tw.tween_method(_set_intensity.bind(lane), 2.5, BASE_INTENSITY, 0.4).set_trans(Tween.TRANS_EXPO).set_ease(Tween.EASE_OUT)
	tw.tween_callback(_set_miss.bind(0.0, lane))
	
	# 2. Efecto de vibración global
	if _shake_tween and _shake_tween.is_valid():
		_shake_tween.kill()
		
	_shake_tween = create_tween()
	
	# Hacemos que el fondo se mueva de forma errática 5 veces muy rápido (efecto "Glitch/Impacto")
	for i in 5:
		var random_offset = Vector2(randf_range(-12.0, 12.0), randf_range(-12.0, 12.0))
		_shake_tween.tween_property(self, "position", _base_pos + random_offset, 0.04)
		
	# Regresamos obligatoriamente a la posición original
	_shake_tween.tween_property(self, "position", _base_pos, 0.05)


# ── Funciones internas ──
func _set_intensity(val: float, lane: int) -> void:
	intensities[lane] = val
	material.set_shader_parameter("intensities", intensities)

func _set_miss(val: float, lane: int) -> void:
	is_miss[lane] = val
	material.set_shader_parameter("is_miss", is_miss)
