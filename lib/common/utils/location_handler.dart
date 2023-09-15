import 'package:geocoder_buddy/geocoder_buddy.dart';
import 'package:location/location.dart';
import 'package:pets_app/models/address/address.dart';
import 'package:pets_app/models/response/result.dart';

import 'logger_service.dart';

class LocationHandler {
  static final locationService = Location();

  // Determine the current device's position
  static Future<LocationData> determinePosition() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    try {
      // Check if location services are enabled
      serviceEnabled = await locationService.serviceEnabled();
      if (!serviceEnabled) {
        // Request to enable location services if not enabled
        serviceEnabled = await locationService.requestService();
        if (!serviceEnabled) {
          LoggerService.w('Location service is disabled');
          return Future.error('Location service is disabled');
        }
      }

      // Check for location permissions
      permissionGranted = await locationService.hasPermission();
      if (permissionGranted == PermissionStatus.denied) {
        // Request location permissions if not granted
        permissionGranted = await locationService.requestPermission();
        if (permissionGranted != PermissionStatus.granted) {
          LoggerService.w('Location permission is denied');
          return Future.error('Location permission is denied');
        }
      }

      // Retrieve the device's location
      return await locationService.getLocation();
    } catch (e) {
      LoggerService.e('Error determining position: $e');
      return Future.error(e.toString());
    }
  }

  // Get the current address based on the device's location
  static Future<Result<AppAddress>> getCurrentAddress() async {
    try {
      final position = await determinePosition();
      GBLatLng gbLatLng =
          GBLatLng(lat: position.latitude ?? 0, lng: position.longitude ?? 0);
      GBData geoData = await GeocoderBuddy.findDetails(gbLatLng);

      final address = AppAddress(
        streetNumber: geoData.address?.road,
        city: geoData.address?.village,
        country: geoData.address?.country,
        latitude: position.latitude,
        longitude: position.longitude,
        postalCode: geoData.address?.postcode,
        state: geoData.address?.state,
        countryCode: geoData.address?.countryCode,
      );

      LoggerService.i(
          'Current address: ${address.toJson()}'); // Log the address

      return Result(data: address);
    } catch (e) {
      LoggerService.e('Error getting current address: $e');
      return Result(error: e.toString());
    }
  }
}
