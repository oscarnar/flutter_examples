import 'dart:io';

import 'package:contact_info/domain/entities/coordinates.dart';
import 'package:geolocator/geolocator.dart';

enum GeoServiceStatus {
  unknownError,
  coordinatesNotFound,
  addressNotFound,
  locationPermissionPermanentlyDenied,
  locationPermissionDenied,
  locationServiceDisabled,
}

class GeoService {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  static Future<Coordinates> determineCoordinates() async {
    bool serviceEnabled;
    LocationPermission permission;

    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return Coordinates(latitude: 0, longitude: 0);
    }

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error(GeoServiceStatus.locationServiceDisabled);
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again.
        return Future.error(GeoServiceStatus.locationPermissionDenied);
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever.
      return Future.error(GeoServiceStatus.locationPermissionPermanentlyDenied);
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    final position = await Geolocator.getCurrentPosition();

    return Coordinates(
      latitude: position.latitude,
      longitude: position.longitude,
    );
  }

  /// Ask to the user to enable the location services.
  /// - If permission had been accepted, return [LocationPermission.always]
  /// or [LocationPermission.whileInUse]
  /// - If permission had been denied, we ask again for permissions,
  /// not if it was denied forever though.
  /// - If permission had been denied forever, the user needs to enable manually
  static Future<LocationPermission> getPermission() async {
    if (Platform.environment.containsKey('FLUTTER_TEST')) {
      return LocationPermission.always;
    }
    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      permission = await Geolocator.requestPermission();
    }
    return permission;
  }
}
