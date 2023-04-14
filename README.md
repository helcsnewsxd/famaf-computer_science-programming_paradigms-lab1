# Preguntas

## 1. ¿Por qué están separadas las funcionalidades en los módulos indicados?

La separación en módulos es importante por distintas razones:

- Organización: es importante que el código de las distintas funcionalidades sea legible, para ello, una estructura clara sirve a la mejor comprensión de las mismas y su correcto funcionamiento. En nuestro caso, la organización consistió en usar 6 módulos principales:
    - **Dibujo.hs**: aquí definimos el tipo principal para realizar los dibujos + las funciones básicas para poder construirlos y operar con los mismos. Gracias al tipo `Dibujo a`, representamos dibujos utilizando constructores específicos sobre *figuras básicas* elegidas por el usuario, capaces de ser manipuladas utilizando las funciones pedidas por la cátedra. El tipo `Dibujo a` puede también ser pensado como un árbol complejo de muchos “nodos”, que serían sus constructores.
    - **FloatingPic.hs** este módulo es importante ya que define un tipo de datos (`FloatingPic`) que sirve para representar ciertas figuras básicas, en un plano, facilitando su posterior procesamiento en *Gloss*. Es un paso intermedio en la construcción de dibujos finales, usando los dibujos definidos en *Dibujo.hs* y la librería *Gloss* como herramientas*.* Básicamente, gracias al tipo *FloatingPic* y el tipo *Output* podemos transformar nuestros Dibujos en “imagenes flotantes” que pueden ser manipuladas y procesadas por la librería Gloss.
    - **Interp.hs** este módulo se encarga de interpretar los dibujos realizados en el tipo definido en *Dibujo.hs* como FloatingPics para luego generar gráficos usando la librería *Gloss* Básicamente, tiene un propósito similar a *Dibujo.hs* sólo que trabaja con algo que *Gloss* puede entender, es decir, una “imagen flotante”, que a su vez, es algo del tipo Picture. También tiene funciones como apilar, juntar, rotar, etc, que sirven para manipular las Pictures producidas con respecto al plano. Finalmente, es el módulo encargado de mostrar en una ventana el resultado del dibujo final a través del uso de la función `InWindow`. Es importante tener en cuenta que este módulo no se encarga de dibujar cosas, solamente interpreta los dibujos ya realizados.
    - **Pred.hs** y **Grilla.hs** Pred.hs no es utilizado en general, sirve más como un spoiler a la dinámica de trabajo en el módulo de *Interp.hs* Luego, *Grilla.hs* lo que hace es construir la grilla que se utiliza de fondo para los dibujos.
- Reutilización del código: así como es importante mantener una organización de las distintas funciones que utilizamos en módulos, también podemos reutilizar funcionalidades especificas de los mismos en otros trabajos o módulos, evitando tener que escribir código nuevamente.
    
    En *Interp.hs*, por ejemplo, hicimos uso del módulo *FloatingPic*.hs para usar el tipo especificado dentro y poder transformar nuestros dibujos en algo que Gloss pueda entender: *Pictures*. En *Grilla.hs* gracias a las funciones Apilar y Juntar, también hizo uso de *Dibujo.hs* para poder crear la grilla.
    
- Abstracción de tipos: Podemos utilizar tipos y funciones definidas en otros módulos sin necesidad de conocer su implementación, ocultando información cuando sea necesario.

## 2. ¿Por qué las figuras básicas no están incluidas en la definición del lenguaje, y en vez es un parámetro del tipo?

Las figuras básicas **no** están incluidas en la definición del lenguaje porque nuestro lenguaje es capaz de construir dibujos en base a figuras elegidas por el usuario. La implementación del mismo, sólo se preocupa de utilizar los constructores definidos, es decir, de apilar, juntar, encimar distintas cosas, sin restricciones en qué pueden ser esas cosas.

Es por eso que se utiliza el tipo FloatingPic, para poder procesar las figuras básicas deseadas dentro de un plano, y que luego puedan ser interpretadas por Interp.hs y ser mostradas en la grilla. No importa, ni nos interesa qué se quiere dibujar.

## 3. ¿Qué ventaja tiene utilizar una función de fold sobre hacer pattern-matching directo?

La ventaja principal que hay entre usar fold y pattern-matching directo es que en fold, no es necesario tener múltiples casos para considerar todos los valores de la estructura a recorrer. La función fold es más general y ayuda a implementar funcionalidades de forma más compacta que pattern-matching. Con fold podríamos trabajar recursivamente sobre cualquier tipo de estructuras de datos sin tener que cambiar demasiado la implementación de nuestro programa, como sucede en pattern matching.
