import 'dart:math';

import 'package:flutter/material.dart';
import 'package:native_plugin/native_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(title: 'Flutter Demo Native Code'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String _timeNative = '';
  String _timeDart = '';
  final TextEditingController _textController = TextEditingController();

  void _getPrimeNative() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        final before = DateTime.now();

        /// Here we are calling to our native function
        _counter = getPrime(int.parse(_textController.text));
        final after = DateTime.now();
        _timeNative = '${after.difference(before).inMilliseconds}ms';
      });
    }
  }

  void _getPrimeDart() {
    if (_textController.text.isNotEmpty) {
      setState(() {
        final before = DateTime.now();
        _counter = getPrimeDart(int.parse(_textController.text));
        final after = DateTime.now();
        _timeDart = '${after.difference(before).inMilliseconds}ms';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Enter a number to get the Nth prime:',
            ),
            SizedBox(
              width: 150,
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  hintText: 'Enter a number',
                  hintStyle: TextStyle(
                    fontSize: 18,
                  ),
                ),
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 25,
                ),
              ),
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text('Time native $_timeNative'),
            // Text('Time Dart $_timeDart'),
          ],
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: _getPrimeNative,
            tooltip: 'Increment',
            child: const Text('C++'),
          ),
          // FloatingActionButton(
          //   onPressed: _getPrimeDart,
          //   tooltip: 'Increment',
          //   child: const Icon(Icons.flutter_dash),
          // ),
        ],
      ),
    );
  }

  int getPrimeDart(int rangenumber) {
    int c = 0, num = 2, i, letest = 0;
    while (c != rangenumber) {
      int count = 0;

      for (i = 2; i <= sqrt(num); i++) {
        if (num % i == 0) {
          count++;
          break;
        }
      }
      if (count == 0) {
        c++;
        letest = num;
      }
      num = num + 1;
    }
    return letest;
  }
}
