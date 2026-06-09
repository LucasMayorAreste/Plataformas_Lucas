extends Area2D

@export var distancia_movimiento: float = 150.0
@export var tiempo_por_trayecto: float = 1.5

func _ready() -> void:
	# Enganchamos la alarma a TODO: cuerpos físicos y otras áreas (como la de tu personaje)
	body_entered.connect(_intentar_matar_cuerpo)
	area_entered.connect(_intentar_matar_area)
	_patrullar()

func _intentar_matar_cuerpo(body):
	# Si la araña toca el cuerpo principal del personaje
	if body.has_method("_on_area_2d_body_entered"):
		body._on_area_2d_body_entered(self)

func _intentar_matar_area(area):
	# Si la araña toca la "caja de daño" (Area2D) del personaje
	var padre = area.get_parent() # Subimos un nivel para encontrar al personaje
	if padre != null and padre.has_method("_on_area_2d_body_entered"):
		padre._on_area_2d_body_entered(self)

func _patrullar():
	var tween = create_tween().set_loops()
	tween.tween_property(self, "position:y", position.y - distancia_movimiento, tiempo_por_trayecto)
	tween.tween_property(self, "position:y", position.y, tiempo_por_trayecto)
