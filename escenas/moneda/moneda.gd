extends Node2D

@export var area_2d: Area2D
@export var reproductor: AudioStreamPlayer2D

# AQUÍ ESTÁ LA MAGIA: Exportamos los puntos para cambiarlos en el panel
@export var puntos_que_da: int = 10 

var contenedor_monedas: ContenedorMonedas

func _ready() -> void:
	area_2d.body_entered.connect(_recogida)
	_iniciar_animacion()

func _recogida(_body):
	# Nos aseguramos de que quien toca la moneda es el "Personaje"
	if _body.name == "Personaje":
		
		# 1. Buscamos el texto de los puntos y le sumamos el valor
		var marcador = get_tree().get_first_node_in_group("HUD")
		if marcador != null:
			marcador.sumar_puntos(puntos_que_da)
			
		# 2. Tu código original intacto (gestión de nivel y sonido)
		contenedor_monedas.moneda_recogida()
		reproductor.reparent(get_parent().get_parent().get_parent()) 
		reproductor.play()
		queue_free()

func _iniciar_animacion():
	var tween: Tween = create_tween()
	tween.set_loops(0)
	tween.tween_property(self, "position:y", position.y - 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT) 
	tween.tween_property(self, "position:y", position.y + 5, 0.5).set_trans(Tween.TRANS_CUBIC).set_ease(Tween.EASE_IN_OUT)
