class Tripulante{
	var property rol = new Libre() //por defecto está libre
	var property edad
	var property fuerza
	var property nave = estacionEspacial
	
	method cambiarDeRol(otroRol) {
		if (!otroRol.cumpleRequisitos(self))
		throw new DomainException(message = "No puede cambiar de roles, no cumple los requisitos del rol")
		self.rol(otroRol)
	}
}

class Rol{

	method esMayorDeEdad(tripulante) = tripulante.edad() > 18
	
	method cumpleRequisitos(tripulante) = self.esMayorDeEdad(tripulante)
}

class Libre inherits Rol{
	
	method prestigio() = 0
}
class Obrero inherits Rol{
	
	override method cumpleRequisitos(tripulante) = super(tripulante) && tripulante.fuerza() > 50
	
	method prestigio() = 50
}


class MrFusion inherits Rol{
	var property conocimiento
	override method cumpleRequisitos(tripulante) = super(tripulante) && (conocimiento > tripulante.nave().conocimientoPromedio() * 2)
	
	method prestigio() = 100	
}

class Capitan inherits MrFusion{
	
	override method cumpleRequisitos(tripulante) = super(tripulante) && tripulante.fuerza() > 73
}

object estacionEspacial{
	
	var property conocimientoPromedio = 20 
	var tripulante = #{}
	
}