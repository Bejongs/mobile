import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../controllers/location_controller.dart';

class LocationMapView extends StatefulWidget {
  const LocationMapView({super.key});

  @override
  State<LocationMapView> createState() => _LocationMapViewState();
}

class _LocationMapViewState extends State<LocationMapView> {
  final mapController = MapController();
  final List<LatLng> routePoints = [];

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Tracking Lokasi"),
        backgroundColor: const Color(0xFFFF4B26),
        foregroundColor: Colors.white,
      ),

      body: Obx(() {
        if (c.position.value == null) {
          return const Center(child: CircularProgressIndicator());
        }

        final pos = LatLng(
          c.position.value!.latitude,
          c.position.value!.longitude,
        );

        routePoints.add(pos);

        return FlutterMap(
          mapController: mapController,
          options: MapOptions(
            initialCenter: pos,
            initialZoom: 18,
            onPositionChanged: (_, __) {},
          ),

          children: [
            TileLayer(
              urlTemplate: "https://cartodb-basemaps-a.global.ssl.fastly.net/light_all/{z}/{x}/{y}.png",
              userAgentPackageName: "com.example.demo_modul4",
            ),


            // 🔵 Polyline jalur yang terbentuk
            PolylineLayer(
              polylines: [
                Polyline(
                  points: routePoints,
                  color: Colors.blue,
                  strokeWidth: 4,
                )
              ],
            ),

            // 📍 Marker posisi user
            MarkerLayer(
              markers: [
                Marker(
                  point: pos,
                  width: 50,
                  height: 50,
                  child: const Icon(
                    Icons.location_on,
                    color: Colors.red,
                    size: 40,
                  ),
                )
              ],
            ),
          ],
        );
      }),
    );
  }
}
