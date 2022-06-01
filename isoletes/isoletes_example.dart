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
