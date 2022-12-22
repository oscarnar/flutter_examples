import 'package:contact_info/domain/entities/person.dart';
import 'package:contact_info/ui/pages/add_contact/view/add_page.dart';
import 'package:contact_info/ui/pages/home/view/home_page.dart';
import 'package:contact_info/ui/pages/map/view/map_page.dart';
import 'package:contact_info/ui/routes/app_routes.dart';
import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  GoRouter get router => GoRouter(
        initialLocation: Routes.home,
        routes: [
          GoRoute(
            path: Routes.home,
            pageBuilder: (context, state) =>
                const CupertinoPage(child: HomePage()),
          ),
          GoRoute(
            path: Routes.map,
            pageBuilder: (context, state) => CupertinoPage(
              child: MapPage(person: state.extra as Person),
            ),
          ),
          GoRoute(
            path: Routes.add,
            pageBuilder: (context, state) => CupertinoPage(child: AddPage()),
          ),
          // GoRoute(
          //   path: Routes.map,
          //   pageBuilder: (context, state) => const MapPage(),
          // ),
        ],
      );
}
