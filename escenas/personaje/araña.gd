extends Area2D

@export var distancia_movimiento: float = 150.0
@export var tiempo_por_trayecto: float = 1.5

# --- NUEVOS INTERRUPTORES PARA EL INSPECTOR ---
@export var movimiento_vertical: bool = false
@export var hace_saltitos: bool = false

func _ready() -> void:
	# El código que ya te funciona para matar (cuerpos y áreas)
	body_entered.connect(_intentar_matar_cuerpo)
	area_entered.connect(_intentar_matar_area)
	_patrullar()

func _patrullar():
	if movimiento_vertical:
		# 1. ARAÑA DE PARED (Sube y baja)
		var tween = create_tween().set_loops()
		tween.tween_property(self, "position:y", position.y - distancia_movimiento, tiempo_por_trayecto)
		tween.tween_property(self, "position:y", position.y, tiempo_por_trayecto)
		
	else:
		# 2. ARAÑA DE SUELO
		if hace_saltitos:
			# Va de izquierda a derecha pero botando
			var tween_x = create_tween().set_loops()
			tween_x.tween_property(self, "position:x", position.x + distancia_movimiento, tiempo_por_trayecto)
			tween_x.tween_property(self, "position:x", position.x, tiempo_por_trayecto)
			
			var tween_y = create_tween().set_loops()
			tween_y.tween_property(self, "position:y", position.y - 30, 0.3).set_trans(Tween.TRANS_SINE)
			tween_y.tween_property(self, "position:y", position.y, 0.3).set_trans(Tween.TRANS_SINE)
		else:
			# Va de izquierda a derecha normal (plana)
			var tween = create_tween().set_loops()
			tween.tween_property(self, "position:x", position.x + distancia_movimiento, tiempo_por_trayecto)
			tween.tween_property(self, "position:x", position.x, tiempo_por_trayecto)


# --- FUNCIONES DE MUERTE (INTACTAS) ---
func _intentar_matar_cuerpo(body):
	if body.has_method("_on_area_2d_body_entered"):
		body._on_area_2d_body_entered(self)

func _intentar_matar_area(area):
	var padre = area.get_parent() 
	if padre != null and padre.has_method("_on_area_2d_body_entered"):
		padre._on_area_2d_body_entered(self)
