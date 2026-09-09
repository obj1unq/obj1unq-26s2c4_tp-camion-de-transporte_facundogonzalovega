# Camión de transporte

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

## Las cosas
De las cosas que puede transportar el camión nos interesa el peso y la peligrosidad:

* Knight Rider: pesa 500 kilos y su nivel de peligrosidad es 10.
* Bumblebee: pesa 800 kilos y su nivel de peligrosidad es 15 si está transformado en auto o 30 si está como robot.
* Paquete de ladrillos: cada ladrillo pesa 2 kilos, la cantidad de ladrillos que tiene puede variar. Para que el paquete no se desarme, lleva refuerzos, que pesan 10kg cada uno. Si el paquete tiene hasta 1000 ladrillos, se utiliza un refuerzo cada 100 ladrillos. Si tiene más ladrillos se debe utilizar un refuerzo cada 50 ladrillos. Los refuerzos se usan enteros, no se puede usar medio refuerzo; por ejemplo para 950 ladrillos se usan 10 refuerzos y para 1020 ladrillos se necesitan 21 refuerzos. La peligrosidad es igual a 50 menos la cantidad de refuerzos utilizados (pero no puede ser negativa, siendo 0 el mínimo posible). 
* Arena a granel: el peso es variable, la peligrosidad es 1.
* Batería antiaérea : el peso es 300 kilos si está con los misiles o 200 en otro caso. En cuanto a la peligrosidad es 100 si está con los misiles y 0 en otro caso.
* Contenedor portuario: un contenedor puede tener otras cosas adentro. El peso es 100 + la suma de todas las cosas que estén adentro. Es tan peligroso como el objeto más peligroso que contiene. Si está vacío, su peligrosidad es 0.
* Residuos radioactivos: el peso es variable y su peligrosidad es 200.
* Embalaje de seguridad: es una cobertura que envuelve a cualquier otra cosa. El peso es el peso de la cosa que tenga adentro. El nivel de peligrosidad es la mitad del nivel de peligrosidad de lo que envuelve.

Testear el peso y la peligrosidad de (al menos):
- Un paquete de 950 ladrillos y otro de 1020 ladrillos.
- Un contenedor portuario con un Knight Rider y un Bumblebee transformado en auto dentro

## Agregados al camión

Se pide agregar estos mensajes al camión:

* `tieneAlgoQuePesaEntre(min, max)`: indica si el peso de alguna de las cosas que tiene el camión está en ese intervalo;
* `cosaMasPesada()`: la cosa más pesada que tenga el camión. Ojo que lo que se pide es _la cosa_ y no su peso.
* `totalBultos()`: la suma de la cantidad de bultos que está transportando. KnightRider, arena a granel y residuos radioactivos son 1 bulto. Bumblebee y embalaje de seguridad son dos. Paquete de ladrillos es 1 hasta 100 ladrillos, 2 de 101 a 300, 3 301 o más. Batería antiaérea: 1 si no tiene misiles, 2 si tiene. Contenedor portuario: 1 + los bultos que tiene adentro.
* `pesos()`: devuelve una lista con _los pesos_ de cada cosa que tiene el camión.

Hacer al menos un test para cada mensaje.

## Modificaciones al cargar cosas
Hemos descubierto que al cargar cosas al camión estas sufren modificaciones. Se pide modelar estas modificaciones, para que ocurran automáticamente, por ejemplo, cuando se ejecuta `camion.cargar(cosa)`. Los cambios que tenemos registrados son estos:

- KnightRider: no hace nada;
- Bumblebee: pasa a robot;
- paquete de ladrillos: pierde 12 ladrillos;
- arena a granel: pierde 15 kilos;
- batería antiaérea: carga misiles;
- contenedor portuario: hace que reaccione cada una de las cosas que tiene adentro;
- residuos radioactivos: agrega 15 kilos;
- embalaje de seguridad: nada.

Elegir una cosa y testear que sufra el efecto indicado al ser cargada al camión.
