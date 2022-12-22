// ignore_for_file: depend_on_referenced_packages

import 'package:contact_info/domain/entities/coordinates.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class LocationsMap extends StatelessWidget {
  const LocationsMap({
    super.key,
    required this.location,
  });

  final Coordinates? location;

  @override
  Widget build(BuildContext context) {
    // final l10n = context.l10n;
    return Stack(
      children: [
        FlutterMap(
          options: MapOptions(
            center: location != null
                ? LatLng(
                    location!.latitude,
                    location!.longitude,
                  )
                : null,
            zoom: 15,
            maxZoom: 18.25,
            minZoom: 5,
          ),
          layers: [
            TileLayerOptions(
              urlTemplate: 'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
              subdomains: ['a', 'b', 'c'],
            ),
            MarkerLayerOptions(
              markers: [
                if (location != null)
                  Marker(
                    width: 80,
                    height: 80,
                    point: LatLng(
                      location!.latitude,
                      location!.longitude,
                    ),
                    builder: (ctx) => const Icon(
                      Icons.pin_drop,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
