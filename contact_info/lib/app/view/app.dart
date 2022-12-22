import 'package:contact_info/domain/blocs/cubit/contacts_cubit.dart';
import 'package:contact_info/l10n/l10n.dart';
import 'package:contact_info/ui/routes/router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// ignore: implementation_imports
import 'package:go_router/src/router.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final router = AppRouter().router;
    return BlocProvider(
      create: (context) => ContactsCubit()..init(),
      child: AppView(router: router),
    );
  }
}

class AppView extends StatelessWidget {
  const AppView({
    super.key,
    required this.router,
  });

  final GoRouter router;

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        appBarTheme: const AppBarTheme(color: Color(0xFF13B9FF)),
        colorScheme: ColorScheme.fromSwatch(
          accentColor: const Color(0xFF13B9FF),
        ),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      // home: const HomePage(),
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
    );
  }
}
