
class Hechicero{
	var energia = 0
//	const rango
	
	method energia() = energia 
	
	method usarHechizo(unHechizo,unHechicero){
		if(!unHechicero.puedeRealizarHechizo(unHechizo))
			self.error("No posee suficiente energia para disparar el hechizo o no cumple con las condiciones")
		self.disminuirEnergia(unHechizo.costoDeEnergia())
		unHechizo.afectar(unHechicero)
	
	}
		
	method puedeRealizarHechizo(unHechizo)=	self.energia() > unHechizo.costoDeEnergia()

	method energiaMaxima() 
	
	method disminuirEnergia(unaCantidad){
		energia -= unaCantidad
	}
	
//	method incrementarEnergia(unaCantidad){
//			if(self.energia() + unaCantidad < self.energiaMaxima())
//					energia += unaCantidad
//			else 
//					energia = self.energiaMaxima()
//	}

	method incrementarEnergia(unaCantidad){
		energia = (energia+unaCantidad).min(self.energiaMaxima())
	}
}

class AprendizDeBrujo inherits Hechicero{
	
//	const tutor = unTutor
//	const unTutor = new Hechicero(energiaMaxima())
		
	override method energiaMaxima() = 50
//	override method puedeRealizarHechizo(unHechizo) = unHechizo.costoDeEnergia() < 40 && unHechizo.costoDeEnergia() <= self.energia()
	override method puedeRealizarHechizo(unHechizo) = unHechizo.costoDeEnergia() < 40 && super(unHechizo)
	

}

class Archimago inherits Hechicero{
	var property nivel 
	override method energiaMaxima() = 100 + self.nivel()*2
	
	override method puedeRealizarHechizo(unHechizo) = !unHechizo.esProhibido() && super(unHechizo)
	
}

class HechiceroSupremo inherits Hechicero{
	override method energiaMaxima() = 500
	override method puedeRealizarHechizo(unHechizo) = true
	
}

class HechizoCurativo{
	var costoDeEnergia
	
	method costoDeEnergia() = costoDeEnergia/2
	
	method esProhibido() = false
	method afectar(unHechicero) = unHechicero.incrementarEnergia(self.costoDeEnergia()*2)

}

class HechizoAvada{
	method costoDeEnergia() = 100
	method esProhibido() = true
	method afectar(unHechicero) = unHechicero.disminuirEnergia(unHechicero.energia())
	
}


