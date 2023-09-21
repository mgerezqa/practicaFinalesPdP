//Tenemos el siguiente código para monitorear cómo el granjero alimenta a sus caballos y chanchos.
//Sabemos que a los caballos los alimenta diferente que a los chanchos, y a su vez, que no a todos los
//chanchos los alimenta igual: a los chanchos gordos les da menos alimento para que no engorden tanto

//Indicar verdadero o falso y justificar en cada caso.
//a. Para que la solución propuesta funcione no es necesario que exista una superclase
//Animal de la cual hereden Caballo y Chancho.

//b. La solución asigna bien las responsabilidades. Es correcto que sea el granjero quien
//determine cómo deben alimentarse chanchos y caballos, ya que se asemeja más a la
//realidad.

//c. La solución hace buen uso de polimorfismo, ya que tanto chanchos como caballos
//entienden los mensajes esChancho y esCaballo.

//d. Es posible adaptar la solución para que, de querer agregar gallinas al modelo a las
//cuales también hay que alimentar a su manera, no haya que cambiar la clase Granjero, ni
//la clase Caballo ni la clase Chancho

class Granjero {
	const animales = []
	method alimentarAnimales(){ 
		self.caballos().forEach({ caballo =>
			caballo.energizar(caballo.racionDiaria())
	})
		self.chanchos().forEach({ chancho =>
			if(chancho.kilos() > 50)
			chancho.aumentarKilos(2)
			else
			chancho.aumentarKilos(3)
	})
}

method caballos() =
animales.filter({animal=>animal.esCaballo()})

method chanchos() =
animales.filter({animal=>animal.esChancho()})
}


class Caballo {
	var racionDiaria
	var energia
	method racionDiaria() = racionDiaria
	method esChancho() = false
	method esCaballo() = true
	method energizar(cant){
	energia *= 1 + cant/100}
}


class Chancho{
	var kilos
	method kilos() = kilos
	method esChancho() = true
	method esCaballo() = false
	method aumentarKilos(cant){
		kilos += cant
	}
}

