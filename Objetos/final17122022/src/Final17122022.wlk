/*Se desea realizar un programa que nos diga si una persona puede jugar a un determinado
 * juego. Se sabe que para jugar a la pelota la persona tiene que tener mas de un año de edad
 * para los juego de mesa tiene que tener estar en el rango de edad que indica el juego y 
 * para los videojuegostiene que tener una edad superior a la minima determinad para el genero del mismo y menor a 80 
 * Ademas los videojuegos solo se pueden jugar si se tiene una consola que lo soporte con lo cual
 * solo podra jugarlo si tiene alguna de esas consolas */

/*Consignas
 * 1. Critique la solución presentada en terminos de declaratividad, polimorfismo,delegacion encapsulamiento y hererencia
 * marcando los diferentes lugares en los cuales encuentra problemas
 * 
 * 2. Codifique una nueva solucióm teniendo en cuenta los problemas detectados y fundamente los cambios
 * realizados conceptualmente para cada cambio no se considerarán respuestas genéricas.
 */

//class Persona{
//var property edad
//var property consolas = []
//method puedeJugar(unJuego){
//		if(unJuego.tipo() == "Juego de mesa")
//			return edad.between(unJuego.edadMinina(),unJuego.edadMaxima())
//		if(unJuego.tipo() == "Videojuego") {
//			if(edad.between(unJuego.genero().edadMinima(),80)){
//			consolas.forEach{
//				consola => unJuego.consolasPosibles().forEach{
//				otraConsola => if(consola == otraConsola) return true
//				}
//			}
//			return false
//		} else return false
//	
//		}
//		return edad > 1 // si llega hasta aca es porque es una pelota
//	}
//}

class Persona{
	var property edad
	var property consolas = []
	
	method puedeJugar(unJuego) = unJuego.puedeSerJugadoPor(self) 
	
	method tieneConsolaCompatible(consolasCompatibles) = self.consolas().any {consola => consolasCompatibles.contains(consola)}
}


/*Declaratividad: La solución presentada no es declarativa, pues para consultar el juego que puede
 * jugar una persona implementa estructuras condicionales como lo son el uso de los if, esto dificulta la lectura
 * del codigo como asi también introduce problemas de escalabilidad en el mismo, pues a medida que nuestro codigo crezca
 * en terminos de requerimientos, se introduzcan nuevos juegos, se tendrá que modificar esta sección del codigo.
 *
 * Polimorfismo: No existe el polimorfismo en la solución presentada.
 * 
 * Delegación: Se puede observar que toda la logica del codigo recae sobre la clase Persona,. 
 * No me parece adecuado esta distribución de responsibilidades, 
 * Podria delegarse la responsabilidad para conocer si una persona puede jugar un juego, preguntandoselo al juego
 * e introduciendo el mensaje "loPuedeJugar(unaPersona)"
 * 
 * Encapsulamiento:
 * La solución no hace un buen uso del encapsulamiento. Las propiedades y métodos están expuestas 
 * directamente en las clases, lo que permite que se acceda y modifique fácilmente desde fuera de las clases. 
 * Esto puede llevar a problemas de mantenimiento y ocultación de información.
 * 
 * Herencia:
 */
 
 
 /*Se desea realizar un programa que nos diga si una persona puede jugar a un determinado
 * juego. Se sabe que para jugar a la pelota la persona tiene que tener mas de un año de edad
 * para los juego de mesa tiene que tener estar en el rango de edad que indica el juego y 
 * para los videojuegos tiene que tener una edad superior a la minima determinad para el genero del mismo y menor a 80 
 * Ademas los videojuegos solo se pueden jugar si se tiene una consola que lo soporte con lo cual
 * solo podra jugarlo si tiene alguna de esas consolas */
 
 
 
object pelota{
	const edadMinima = 1
	
	method edadMinima() = edadMinima
	
	method puedeSerJugadorPor(jugador) = jugador.edad()> edadMinima
	
}

class juegoDeMesa{
	const edadMinima 
	const edadMaxima
	
	method puedeSerJugadorPor(jugador) = jugador.edad().between(edadMinima,edadMaxima)
	
}

class videoJuego{
	const edadMinima 
	const edadMaxima = 80
	var property consolasPosibles
	var property genero
	
	method puedeSerJugadorPor(jugador) = 
		genero.edadMinima()< jugador.edad() && jugador.edad() < edadMaxima && jugador.tieneConsolaCompatible(self.consolasPosibles())
		
	
}

class Genero{
	var property titulo
	var property edadMinima

}
