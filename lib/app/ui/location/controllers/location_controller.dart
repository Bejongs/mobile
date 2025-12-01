import 'dart:async';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';

class LocationController extends GetxController {
  final isGpsMode = false.obs; // false = NETWORK, true = GPS
  final position = Rxn<Position>();
  final accuracy = 0.0.obs;
  final speed = 0.0.obs;
  final isLoading = false.obs;

  StreamSubscription<Position>? positionStream;

  @override
  void onInit() {
    super.onInit();
    initLocation();
  }

  Future<void> initLocation() async {
    bool enabled = await Geolocator.isLocationServiceEnabled();
    if (!enabled) {
      await Geolocator.openLocationSettings();
      return;
    }

    LocationPermission perm = await Geolocator.checkPermission();
    if (perm == LocationPermission.denied) {
      perm = await Geolocator.requestPermission();
      if (perm == LocationPermission.deniedForever) return;
    }

    startTracking();
  }

  /// 🔥 START TRACKING — GPS atau NETWORK tergantung toggle
  void startTracking() {
    positionStream?.cancel();

    LocationSettings settings;

    if (isGpsMode.value) {
      // MODE GPS
      settings = const LocationSettings(
        accuracy: LocationAccuracy.bestForNavigation,
        distanceFilter: 1, // update setiap 1 meter
      );
    } else {
      // MODE NETWORK
      settings = const LocationSettings(
        accuracy: LocationAccuracy.low, // hanya WiFi/BTS
        distanceFilter: 5,
      );
    }

    positionStream = Geolocator.getPositionStream(locationSettings: settings)
        .listen((pos) {
      position.value = pos;
      accuracy.value = pos.accuracy;
      speed.value = pos.speed;
    });
  }

  /// 🔄 TOGGLE GPS / NETWORK
  void toggleMode() {
    isGpsMode.value = !isGpsMode.value;
    startTracking();
  }

  @override
  void onClose() {
    positionStream?.cancel();
    super.onClose();
  }
}
