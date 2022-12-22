import 'dart:developer';

import 'package:contact_info/domain/entities/person.dart';
import 'package:contact_info/ui/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:go_router/go_router.dart';

class ContactTile extends StatelessWidget {
  const ContactTile({
    super.key,
    required this.person,
  });

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const ScrollMotion(),
        children: [
          SlidableAction(
            onPressed: (context) => log('Tap on edit'),
            backgroundColor: const Color(0xFF7BC043),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Editar',
          ),
          SlidableAction(
            onPressed: (context) => log('Tap on remove'),
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Borrar',
          ),
        ],
      ),
      child: ListTile(
        title: Text(person.name),
        onTap: () => GoRouter.of(context).push(Routes.map, extra: person),
      ),
    );
  }
}
