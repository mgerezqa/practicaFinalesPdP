//En una agencia de publicidad graficas existen dos tipos de publicidades:
//Publicidades tradicionales: se publican en diarios y revistas de la agencia, y tienen un costo para el cliente que varia segun
//el plan que contrate para esa publicidadad, permitiendo cambiarlo mas adelante:
//	Estandar: 1000
//	Platinum: 800 si el cliente tiene activas mas de 3 publicidades. Si no 1100
//	Gold: 1200 / cantidad de publicidades activas del cliente.
//
//Publiciadades no tradicionales: se publican en distintos medios a elección, cada uno de los cuales tiene un 
//costo propio. el costo de la publicidad no tradicional es la suma de estos costos.
//
//Las publicidades que no están activas no tienen costo. En cualquier momento podrían dejar de estar activas
//a pedido del cliente

//1.Responder Vo F justificando en todos los casos:
//	a. no hay logica repetida en la solucion
//	b.hay problemas en el manejo del estado del sistema
//	c. Si se quisiera definir un metodo costoTotal en la claseCliente, se podria resolver facil gracias
//	d. que todas las publicidades entienden el mensaje costo.
//	e. Retornar un string si se configuro mal el plan no es conveniente. Seria mejor retornar -1.
//
//2. Desarrollar una solucion superadora para el problema. En caso de aprovechar conceptos del paradigma
//que no se estuvieran aprovechado en la solucion original explicarlo brevemente.

class Cliente{
	var property publicidades = []

}

class PublicidadNoTradicional{
	var property medios = []
	var property estaActiva = true
	
	method costo() {
		if (estaActiva)
		return medios.sum{ medio => 
			medio.costo()
		}
		else return 0
	}
	
}

class PublicidadTradicional{
	var property plan
	var property estaActiva = true
	var cantPublicidadesActivas = 0
	
	method costo(cliente){
		cantPublicidadesActivas = cliente.publicidades().count()({publicidad => 
			publicidad.estaActiva()
		})

	if(not estaActiva) return 0
	
	if(plan == "estandar") return 1000
	if(plan == "platinum"){
		if(3 < cantPublicidadesActivas) return 800
		else return 1100
	}
	if(plan == "gold")
	 return 1200 / cantPublicidadesActivas
	 return "Plan inválido"
	
}
}