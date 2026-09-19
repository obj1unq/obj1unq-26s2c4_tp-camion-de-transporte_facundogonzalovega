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
        pesoCarga += cosa.peso()
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

    method excedidoDePeso(){
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
}
