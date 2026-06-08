extends Label

var puntos_totales = 0

func sumar_puntos(cantidad):
	puntos_totales += cantidad
	text = "Puntos: " + str(puntos_totales)
