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

//PREGUNTAS 

//Asumiendo que el objeto “estaciónEspacial” existe y está bien codificado, se pide:
//1. Responder verdadero o falso y justificar en todos los casos:
	//a. Estaría mal que Libre, Obrero y MrFusion sean subclases de Tripulante.
	//b. Puede agregarse un rol Capitán sin necesidad de modificar código existente (el rol Capitán es como Mr
	//Fusión, pero además de ser inteligente debe ser fuerte, con fuerza mayor a 73).
	//c. Puede agregarse el rol Capitán sin necesidad de repetir código.
	//d. Suponiendo que en la estación hay varios tripulantes menores de edad. Puedo hacer:
	//Wollok: tripulantes.forEach({ tripu => tripu.rolActual(“Obrero”) })
	//Y jamás me enteraría de que hubo un error.

//2. Reescribir la solución (incluyendo al capitán) solucionando los problemas descubiertos y utilizando
//correctamente los conceptos vistos en la materia.

//3. Explicar conceptualmente los cambios realizados, indicando cómo se resuelven los problemas encontrados en el
//punto 1.


//RESPUESTAS
// 1a. Verdadero. No es correcta esa decisión de diseño, pues estariamos acoplando la clase con el tipo de 
//rol del tripulante, dejando invariante la misma (rol), cuando el enunciado nos indica que el rol puede cambiar.
//En wollok, una vez que se instancia un objeto perteneciente a una clase, no puede ser modificado

//	1b. Falso. Para agregar ese rol, tendría que expandir la logica implementada haciendo uso de otro if()
//	1c. Falso. Por punto b.
//  1d. Verdadero. El modelo actual no contempla el manejo de errores, sino que improvisa con un retorno de mensaje por una rama
// de un if

//2 ver solución propuesta
//3 , se implementó una solución nueva, haciendo el correcto uso de los conceptos:

//delegación : Se delega en cada rol, la verificación de requisitos por parte del tripulante

// herencia : Se crea una interfaz llamada Rol que actua como clase abstracta para las clases hijas, Obrero , Mr Fusion y Libre,
//logrando evitar la repetición de comportamiento para verificar la mayoria de edad y a la vez permitiendo generar nuevos comportamientos propios para sus subclases

//Polimorfismo: Se demuestra polimorfismo en los métodos como cumpleRequisitos. 
//Cada clase derivada (como Obrero, MrFusion, y Capitan) proporciona su propia implementación de este método,
// lo que permite que el método se comporte de manera diferente según el tipo de objeto que lo invoca.

//Encapsulamiento: 
// Las propiedades de las clases, rol, edad, fuerza, y nave, están encapsuladas 
//dentro de las clases y solo se pueden acceder a través de métodos públicos. 
//Por ejemplo, el método cambiarDeRol encapsula el cambio de rol y verifica los requisitos antes de realizar el cambio.