class Personaje{
	const enemigos = #{}	
	var property salud = 0 //salud 
	
	method recibirDanio(cantidad,personaje){
		if(salud < 0)
		throw new DomainException(message = "El personaje esta muerto")
		salud -= cantidad
		self.agregarEnemigo(personaje)
	}
	
	method agregarEnemigo(personaje){
		enemigos.add(personaje)
	}
	
	method atacar(personaje){
		
	}	
}

class Villano inherits Personaje {
	var property arma
	override method atacar(personaje){
		personaje.recibirDanio(self.danioDeArma(),self) // villano ataca con el poder de su arma y se agrega como enemigo del personaje atacado
//		personaje.agregarEnemigo(self)
	}
	
	method danioDeArma() = arma.danioBase()/ arma.areaDeEfecto()
}

class Arma{
	var property danioBase
	var property areaDeEfecto
}

class Heroe inherits Personaje{
	var habilidades = #{}
//	const habilidades = []
	const aliados = #{}
	
	override method atacar(personaje){
		if (not enemigos.contains(personaje)){
			throw new DomainException(message = "El personaje atacado no es un enemigo")
//			return "El personaje atacado no es un enemigo"
			
		}
		personaje.recibirDanio(self.poder(),self)
//		personaje.recibirDanio(self.poder())
//		personaje.agregarEnemigo(self)	
	}
	
	method poder() = aliados.size() * habilidades.sum({h => h.poder()})
	
	method agregarHabilidad(unaHabilidad){
		habilidades.add(unaHabilidad)
	}
}

class Habilidad {
	var property poder 
}

//1. #Responder V o F y Justificar:
//	#a. El ataque de un heroe no maneja correctamente el caso de atacar a un personaje que no es enemigo.

//Verdadero. Porque la función del condicional es "manejar" una situación no esperada, por lo tanto en lugar de retornar un mensaje
//deberia lanzarse una excepción con un mensaje informando del error o situación no esperada.

//	#b. Hay logica comun entre villanos y heroes que podria generalizarse.
//Verdadero, modificando la clase Personaje podemos incorporar el atributo salud , y a la vez definir el método atacar con dos parametros (danio, personaje)
//donde cada subclase redefinirá el danio que causara al personaje atacado y a la vez se agregará a la lista de enemigos

//	#c. No hay problemas de delegación en la solución.
//No hay problemas, de delegación

//	#d. Los heroes son polimorficos con las habilidades ya que ambos entienden el mensaje poder()

//Falso. Para que en la solución exista el polimorfismo tienen que haber 3 entidades que compartan la misma interfaz, y una de ellas
//implemente/realice una petición de modo que las otras dos puedan entender el mensaje de acuerdo a sus propias especificaciones.
//La solucion no presenta polimorfismo.

//	#e. Para que un heroe se convierta en villano alcanza con instanciar villano, iniciandolo con el arma que corresponda y los enemigos que tenia la instancia
//	original de la clase heroe.

// En la solución proporcionada, la instancia de Heroe y la instancia de Villano son dos clases distintas con comportamientos diferentes. 
//Simplemente instanciar un Villano con el arma y los enemigos de un Heroe no cambiará automáticamente la clase 
//ni el comportamiento del personaje. 
//Para que un héroe se convierta en un villano,se necesitaría una lógica adicional que modifique la instancia y cambie su tipo de clase, 
//lo cual no está implementado en la solución actual.

//
//2. Proponer una solucionar alternativa realizando las mejores que consideres apropiadas en base a las observaciones del punto anterior.



//const armaDePrueba = new Arma(danioBase = 20,areaDeEfecto = 10)
//const sonic = new Persona (clase = new Villano(arma = armaDePrueba))
//const villanoTipico = new Persona (clase = new Villano ( arma = armaDePrueba))
//const hereoTipico = new Persona(clase = new Heroe ())
//sonic.cambiarDeProfesion(villanoTipico)//si es heroe cambia  a villano
