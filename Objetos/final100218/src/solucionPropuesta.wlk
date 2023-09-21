class Granjero {
	
	const property animales = []
	
	method alimentarAnimales() {
		self.animales().forEach({animal => animal.come()})
	}
}


class Caballo {
	var property racionDiaria //el paramentro en come, lo uso para lograr el polimorfismo, pero segun la implementacion, es el caballo mismo el responsable de limitar su cantidad de comida
	var property energia

	method come(){ energia *= 1 + self.racionDiaria()/100}
}


class Chancho{
	var kilos
	method kilos() = kilos
	method come(){
		if(self.kilos()>50) self.aumentarKilos(2) else self.aumentarKilos(3)
	}
	
	method aumentarKilos(cant){
		kilos += cant
	}
}



//Indicar verdadero o falso y justificar en cada caso.
//a. Para que la solución propuesta funcione no es necesario que exista una superclase
//Animal de la cual hereden Caballo y Chancho.

//Respuesta: Verdadero, no es necesario el uso de la herencia, se puede lograr el polimorfismo,
//agregando a la interfaz de los animales el mensaje come(), y que cada animal sea el responsable
//de implementar la logica correspondiente para indicar la forma que tiene de comer/incrementar energia o kilos


//b. La solución asigna bien las responsabilidades. Es correcto que sea el granjero quien
//determine cómo deben alimentarse chanchos y caballos, ya que se asemeja más a la
//realidad.

//Respuesta: Falso, no es correcto la afirmación,  como  programadores no buscamos modelar la realidad, sino
//un sistema que responda a los requerimientos , para este caso, hubiese sido mejor crear un metodo en las clases
//chancho y caballo que controle la forma en la que se alimentan (Ver solución propuesta)


//c. La solución hace buen uso de polimorfismo, ya que tanto chanchos como caballos
//entienden los mensajes esChancho y esCaballo.

//Respuesta: Falso, no es correcto preguntar por la identidad de un objeto, no tiene sentido, no hace buen uso del principio de 
//encapsulamiento donde cada objeto es responsable de su propio estado y comporramiento

//d. Es posible adaptar la solución para que, de querer agregar gallinas al modelo a las
//cuales también hay que alimentar a su manera, no haya que cambiar la clase Granjero, ni
//la clase Caballo ni la clase Chancho

//Respuesta: Falso, el modelo presentado no es escalable, pues para agregar mas animales habria que 
//modificar y expandir la logica de control que está explicita en el granjero. 
//
