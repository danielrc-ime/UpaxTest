# MVVM UPAX
Respuesta a preguntas

## Comenzando 🚀

- Explique el ciclo de vida de un view controller.
```
Inicia cargando viewDidLoad donde se configuran las variables de la vista inicialemnte, posteriormente viewWillAppear que indica que ya ha colocado las vistas, viewDidAppear indicando que las vistas ya se mostraron
```

- Explique el ciclo de vida de una aplicación.
```
- Inicia cuando el usuario da click en la app cargando UIApplication
- Se inicializa todas las variables en willFinisLaunchingWithOptions
- Se activa la app es decir empieza a correr y se vuelve activa
```

- En que casos se usa un weak, un strong y un unowned.
```
- weak se utiliza cuando requerimos que la variable pueda ser cambiada a "nil" en caso de que la memoria del dispositivo necesite liberar espacio
- strong lo declaramos en una variable cuando requerimos que no sea eliminada en caso de llenado de memoria
- unowned se utiliza cuando requerimos que la variable no sea dealocada
```

- Que es ARC?
```
Automatic Reference Counting, se encarga de liberar espacio en la memoria cuando las variables no estén siendo utilizadas
```

- Analizando capturas de pantalla
```
Si el storyboard tiene como nombre "main" y esta configurado con el identificador "ViewController" el código podrá ejecutarse y el color de la vista será rojo de acuerdo a lo programado en la clase ViewController, ya que de acuerdo al ciclo de vida de la app la función viewDidLoad() se ejecuta después de "didFinishLaunchingWithOptions"
```