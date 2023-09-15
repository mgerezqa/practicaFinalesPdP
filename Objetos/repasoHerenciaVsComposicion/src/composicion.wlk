
class Hechicero{
	var property energia = 0
	var property rango = aprendiz
	var property nivel = 0
	var property enemigo = null
	
	method energiaMaxima() = self.rango().energia(self)
	
	
	method usarHechizo(hechizo) {
		if(!hechizo.puedeSerUsadoPor(self,self.rango()))
			throw new DomainException(message = "El hechizo no puede ser lanzado el hechiceor no cumple los requisitos")
		hechizo.usarEn(self)
	}

	
	method recuperarEnergia(cantidad) {
		energia = (energia + cantidad).min(self.energiaMaxima())
	}
	
	method consumirEnergia(cantidad) {
		energia = (energia - cantidad).max(0)
	}
	
	method perderTodaLaEnergia(){
		energia = 0
	}
	
	//	method cambiarDeRango() = rango.ascender()
	

}

class Hechizo{
	var property energia = 0
	var property esProhibido = false
	
	method puedeSerUsadoPor(hechicero,rango) = self.tieneSuficienteEnergiaMagica(hechicero) && rango.permiteUsar(self)
	
	method tieneSuficienteEnergiaMagica(hechicero) = hechicero.energia() > self.energia()
}


class hechizoCurativo inherits Hechizo{
	
	method usarEn(hechicero) { 
		hechicero.consumirEnergia(self.gastoDeEnergia())
		hechicero.recuperarEnergia(self.gastoDeEnergia()*2)
	}
	
	method gastoDeEnergia() = energia*0.5
}

class avadaKedavra inherits Hechizo{
 	
	override method esProhibido() {
		esProhibido = true
	}
	
	method usarEn(hechicero) { 
		hechicero.consumirEnergia(100)
		hechicero.enemigo().perderTodaLaEnergia()
	
	}
	
}

object aprendiz{

	var property tutor
	const energia = 50
	
	method energia(hechicero) = energia
	
	method permiteUsar(hechizo) = hechizo.energia() <= 40
	
	
}

object archimago{
	method energia(hechicero) = hechicero.nivel()*2 + 100
	method permiteUsar(hechizo) = !hechizo.esProhibido()
}


object supremo{
	
	const energia = 500
	
	method energia(hechicero) = energia
	
	method permiteUsar(hechizo) = true
}

