import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart';

class MyLaguages {
  static String english = 'en';
  static String spanish = 'es';
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

  static _MyAppState? of(BuildContext context) =>
      context.findAncestorStateOfType<_MyAppState>();
}

class _MyAppState extends State<MyApp> {
  Locale _locale = Locale(Intl.systemLocale);
  void setLocale(String locale) {
    setState(() {
      _locale = Locale(locale);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: const MyHomePage(),
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      locale: _locale,
      supportedLocales: AppLocalizations.supportedLocales,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).title),
        actions: [
          PopupMenuButton(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Center(child: Text(Intl.getCurrentLocale())),
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  value: MyLaguages.english,
                  child: Text(AppLocalizations.of(context).english),
                  onTap: () {
                    setState(() {
                      Intl.defaultLocale = MyLaguages.english;
                      MyApp.of(context)?.setLocale(Intl.getCurrentLocale());
                    });
                  },
                ),
                PopupMenuItem(
                  value: MyLaguages.spanish,
                  child: Text(
                    AppLocalizations.of(context).spanish,
                  ),
                  onTap: () {
                    setState(() {
                      Intl.defaultLocale = MyLaguages.spanish;
                      MyApp.of(context)?.setLocale(Intl.getCurrentLocale());
                    });
                  },
                ),
              ];
            },
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).pressButtonLabel,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
            Text(
              AppLocalizations.of(context).helloWorld,
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: AppLocalizations.of(context).incrementTooltip,
        child: const Icon(Icons.add),
      ),
    );
  }
}
