/** First Wollok example */
	class Tripulante { 
	var property rolActual = "Libre"
	var property edad
	var property fuerza
	const property conocimiento
	method mayorDeEdad() = self.edad() >= 18
	method prestigio() =
		if (self.rolActual() == "Libre") 0 else
		if (self.rolActual() == "Obrero") 50 else
		if (self.rolActual() == "MrFusión") 100 else -1
	method podesCambiarA(otroRol) =
	otroRol == "Libre" || otroRol == "Obrero" && self.condicionParaObrero() || otroRol == "MrFusión" && self.condicionParaMrFusion()
	method condicionParaObrero() = self.mayorDeEdad() && self.fuerza() > 50
	method condicionParaMrFusion() = self.mayorDeEdad() && self.conocimiento() > estacionEspacial.conocimientoPromedio() * 1.21
//	method rolActual(otroRol){
//		if (self.podesCambiarA(otroRol)) {
//		rolActual = otroRol
//		// Se requiere que solamente MrFusión
//		// registre conocimientos
//		if (self.rolActual() == "Libre" ||
//		self.rolActual() == "Obrero")
//		conocimientos = 0
//		return 0
//	} else {
//		return "Error: No se pudo cambiar rol, no cumple
//		requisito!"
//		}
//	}
}

//agregado para que compile
object estacionEspacial{
	
	var property conocimientoPromedio = 10 
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
