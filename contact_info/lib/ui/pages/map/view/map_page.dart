import 'package:contact_info/domain/entities/person.dart';
import 'package:contact_info/ui/pages/map/widgets/map.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class MapPage extends StatelessWidget {
  const MapPage({super.key, required this.person});

  final Person person;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Center(
        child: LocationsMap(
          location: person.address.coordinates,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => launchUrl(
          Uri(scheme: 'sms', path: person.phone),
        ),
        child: const Icon(
          Icons.call,
          color: Colors.white,
        ),
      ),
    );
  }
}
