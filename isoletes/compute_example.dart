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
