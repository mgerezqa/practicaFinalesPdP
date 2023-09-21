class Cliente{
	var property publicidades = []

	method costoTotalDePublicidadesActivas() = self.costoDePublicidades(self.publicidadesActivas())
	
	method costoDePublicidades(lista) =  lista.sum{publi => publi.costo(self)}
	
	method cantidadDePublicidades() = self.publicidades().size()
	
	method publicidadesActivas() = self.publicidades().filter{publi => publi.estaActiva()}
	
	method cantidadDePublicidadesActivas() = self.publicidadesActivas().size()
}

class PublicidadNoTradicional{
	var property medios = []
	var property estaActiva = true
	
	method costo(cliente) {
		if (estaActiva)
		return medios.sum{ medio => medio.costo(cliente) }
		else return 0
	}
}


class PublicidadTradicional{
	var property plan
	var property estaActiva = true
	
	method costo(cliente) = plan.costo(cliente)
}

//Planes
object estandar{
	method costo(cliente) = 1000
}

object platinum{
	method costo(cliente) = if (cliente.cantidadDePublicidades() > 3) 800 else 1100
	
}

object gold{
	method costo(cliente) = 1200/cliente.cantidadDePublicacionesActivas()
}

//Medios

object tv{
	
	method costo(cliente) = 3000
}

object radio{
	
	method costo(cliente) = 2000
}