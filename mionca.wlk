/* # Camión de transporte

Una empresa de transporte quiere administrar mejor las cargas que lleva un camión.

Para eso requiere un sistema que le permita planificar qué cosas debe llevar el camión sin sobrepasar su capacidad. Por otro lado, las cosas que transporta tienen un nivel de peligrosidad. Este nivel es usado para impedir que cosas que superen cierto nivel de peligrosidad circulen en determinadas rutas.

## El camión
Se pide que el camión entienda los siguientes mensajes:

* `cargar(cosa)`: para agregar una cosa en el camión, validando que no supere el peso máximo de 2.5 toneladas;
* `descargar(cosa)`: para eliminar una cosa del camión, validando que no se intente descargar algo que no estaba cargado;
* `pesoTotal()`: es la suma del peso del camión vacío (tara) y su carga. La tara del camión es de 1 tonelada (1000 kilogramos);
* `excedidoDePeso()`: indica si el peso total es superior al peso máximo;
* `objetosPeligrosos(nivel)`: todos los objetos cargados que superan el nivel de peligrosidad indicados por el valor del parámetro;
* `objetosMasPeligrososQue(cosa)`: todos los objetos cargados que son más peligrosos que la cosa;
* `puedeCircularEnRuta(nivelMaximoPeligrosidad)` Puede circular si ninguna cosa que transporta supera el `nivelMaximoPeligrosidad`.

Incluir como mínimo los siguientes tests:
* Para `cargar` y `descargar`, dos tests de cada uno (un caso exitoso y otro inválido).
* Para los demás métodos, al menos un test de cada uno.
*/

object camion {
    var pesoCarga = 0
    const carga = []
    
    method cargar(cosa){
        self.validarCarga(cosa)
        carga.add(cosa)
        cosa.reaccionarAlSerCargada()
        pesoCarga += cosa.peso() // esto va al final porque cuando reacciona la cosa puede perder peso
    }

    method descargar(cosa){
        self.validarDescarga(cosa)
        carga.remove(cosa)
        pesoCarga -= cosa.peso()
    
    }

    method validarCarga(cosa) {
        if(self.pesoTotal() + cosa.peso() > 2500){
            self.error("No se puede cargar mas")
        }
    }

    method validarDescarga(cosa) {
        if(not carga.contains(cosa)){
            self.error("No está acá")
        }
    }

    method pesoTotal() {
        return pesoCarga + self.pesoTara()
    }

    method pesoTara() {
        return 1000
    }

    method excedidoDePeso(){ // para que sirve esto si tengo que validar que no cargue mas del peso maximo?
        return self.pesoTotal() > 2500
    }

    method objetosPeligrosos(nivel) {
        const peligrosos = carga.filter({ cosa => cosa.nivelPeligrosidad() > nivel })
        return peligrosos
    }

    method objetosMasPeligrososQue(cosa) {
        const masPeligrosos = carga.filter({ elemento => elemento.nivelPeligrosidad() > cosa.nivelPeligrosidad() })
        return masPeligrosos
    }

    method puedeCircularEnRuta(nivelMaximoPeligrosidad) {
        const objetosProhibidos = self.objetosPeligrosos(nivelMaximoPeligrosidad)
        return objetosProhibidos.isEmpty()
    }
    method tieneAlgoQuePesaEntre(min, max) {
        return carga.any({ cosa => cosa.peso() >= min && cosa.peso() <= max })
    }

    method cosaMasPesada() {
        return carga.max({ cosa => cosa.peso() })
    }

    method totalBultos() {
        return carga.sum({ cosa => cosa.cantidadDeBultos() })
    }

    method pesos() {
        return carga.map({ cosa => cosa.peso() })
    }
}
object knightRider {
    method peso() = 500
    method nivelPeligrosidad() = 10

    method cantidadDeBultos() = 1

    method reaccionarAlSerCargada() { // fallan los tests de "agregados al camion" sin esto

    }
}

object bumblebee {
    var modo = "auto"

    method transformarse() {
        modo = "robot"
    }

    method transformarseEnAuto() {
        modo = "auto"
    }

    method peso() = 800

    method nivelPeligrosidad() {
        if (modo == "auto") {
            return 15
        } else {
            return 30
        }
    }

    method reaccionarAlSerCargada() {
        self.transformarse()
    }

    method cantidadDeBultos(){
        return 2
    }
}

/*
* Paquete de ladrillos: cada ladrillo pesa 2 kilos, la
  cantidad de ladrillos que tiene puede variar. Para que
  el paquete no se desarme, lleva refuerzos, que pesan
  10kg cada uno. Si el paquete tiene hasta 1000 ladrillos,
  se utiliza un refuerzo cada 100 ladrillos. Si tiene más
  ladrillos se debe utilizar un refuerzo cada 50 ladrillos.
  Los refuerzos se usan enteros, no se puede usar medio
  refuerzo; por ejemplo para 950 ladrillos se usan 10
  refuerzos y para 1020 ladrillos se necesitan 21
  refuerzos. La peligrosidad es igual a 50 menos la
  cantidad de refuerzos utilizados
  (pero no puede ser negativa, siendo 0 el mínimo posible). 
*/

object paqueteLadrillos {
    var cantidadDeLadrillos = 0

    method cantidadCambiada(numero) {
        cantidadDeLadrillos = numero
    }

    method peso() {
        return self.pesoLadrillos() + self.pesoRefuerzos()
    }

    method pesoLadrillos(){
        return cantidadDeLadrillos * 2
    }

    method pesoRefuerzos(){
        return self.cantidadDeRefuerzos() * 10
    }

    method cantidadDeRefuerzos() {
        if (cantidadDeLadrillos <= 1000) {
            return (cantidadDeLadrillos / 100).ceil()
        } else {
            return (cantidadDeLadrillos / 50).ceil()
        }
    }

    method nivelPeligrosidad(){
        return (50 - self.cantidadDeRefuerzos()).max(0)
    }

    method cantidadDeBultos() {
        if (cantidadDeLadrillos <= 100) {
            return 1
        } else if (cantidadDeLadrillos <= 300) {
            return 2
        } else {
            return 3
        }
    }

    method reaccionarAlSerCargada() {
        cantidadDeLadrillos -= 12
    }
}

object arenaAGranel {
    var pesoActual = 0

    method pesoCambiado(peso) {
        pesoActual = peso
    }

    method peso() {
        return pesoActual
    }

    method nivelPeligrosidad(){
        return 1
    }

    method cantidadDeBultos() = 1

    method reaccionarAlSerCargada() {
        pesoActual -= 15
    }
}


object bateriaAntiaerea {
    var tieneMisiles = true

    method cambiarEstado(estado) {
        tieneMisiles = estado
    }

    method peso() {
        if (tieneMisiles) {
            return 300
        } else {
            return 200
        }
    }

    method nivelPeligrosidad() {
        if (tieneMisiles) {
            return 100
        } else {
            return 0
        }
    }

    method cantidadDeBultos() {
        if (tieneMisiles) {
            return 2
        } else {
            return 1
        }
    }

    method reaccionarAlSerCargada() {
        tieneMisiles = true
    }
}

object contenedorPortuario {
    const cosasDentro = []

    method peso(){
        return 100 + self.pesoCosasDentro()
    }

    method nivelPeligrosidad() {
        if (cosasDentro.isEmpty()) {
            return 0
        } else {
            const niveles = cosasDentro.map({ cosa => cosa.nivelPeligrosidad() })
            return niveles.max()
        }
    }

    method pesoCosasDentro(){
        return cosasDentro.sum({ cosa => cosa.peso() })
    }

    method cantidadDeBultos() {
        return 1 + cosasDentro.sum({ cosa => cosa.cantidadDeBultos() })
    }

    method reaccionarAlSerCargada() {
        cosasDentro.forEach({ cosa => cosa.reaccionarAlSerCargada() })
    }
}

object residuosRadioactivos {
    var pesoActual = 0

    method pesoCambiado(peso) {
        pesoActual = peso
    }

    method peso() {
        return pesoActual
    }

    method nivelPeligrosidad(){
        return 200
    }

    method cantidadDeBultos() {
        return 1
    }

    method reaccionarAlSerCargada() {
        pesoActual += 15
    }
}

object embalajeSeguridad {
    var cosaEnvuelta = null

    method envolver(cosa) {
        cosaEnvuelta = cosa
    }

    method peso() {
        return cosaEnvuelta.peso()
    }

    method nivelPeligrosidad() {
        return cosaEnvuelta.nivelPeligrosidad() / 2
    }

    method cantidadDeBultos() = 2

    method reaccionarAlSerCargada() {

    }
}