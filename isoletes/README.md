# Isolates

Un par de ejemplos muy basico para poder conocer como trabajar con Isolates.  
Para esto se usaron las dos formas de crear un Isolate. Compute y Isolate.spawn.  

Nota: Para ejecutar el ejemplo de compute es necesario de Flutter por lo que se debe correr en un proyecto Flutter.

## Compute

```dart
import 'package:flutter/foundation.dart';

/// Nota: Compute necesita de la libreria Flutter foundation
/// por lo que solo se podra correr en un proyecto Flutter
void main() async {
  final data = {'data': 'here is some data.'};
  // Llamamos a compute de manera similar a una funcion async
  final computedData = await compute(heavyFunction, data);
}

// Top Level Function
int heavyFunction(Map<String, dynamic> map) {
  final data = map['data'];
  int computedData = 0;

  // Procesamiento pesado
  for (var i = 0; i < data.length; i++) {
    computedData += i;
  }

  return computedData;
}
```
## Isolate.spawn
```dart
import 'dart:isolate';

void main() async {
  // Stream para manejar la comunicacion entre isoletes
  final port = ReceivePort();

  final data = {'port': port.sendPort, 'data': 'here is some data.'};

  // Podemos manejar el isolete con llamados (isolate.kill / pause / resume)
  final isolate = await Isolate.spawn(heavyFunction, data);

  // Si es necesario podemos obtener mensajes usando el stream
  port.listen((message) => print(message));
}

// Top Level Function
void heavyFunction(Map<String, dynamic> map) {
  final SendPort port = map['port'];
  final String data = map['data'];
  int computedData = 0;

  // Procesamiento pesado
  for (var i = 0; i < data.length; i++) {
    // Podemos enviar datos usando el stream
    port.send('data$i');
    computedData += i;
  }

  // Finalmente enviamos el resultado y eliminamos el isolete
  Isolate.exit(port, computedData);
}
```


![Alt Text](https://media.giphy.com/media/QNFhOolVeCzPQ2Mx85/giphy.gif)