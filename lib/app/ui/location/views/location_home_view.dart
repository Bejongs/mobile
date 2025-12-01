import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/location_controller.dart';
import 'package:demo_modul4/app/ui/location/views/location_map_view.dart';

class LocationHomeView extends StatelessWidget {
  const LocationHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final c = Get.find<LocationController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Eksperimen Lokasi - Modul 5"),
        backgroundColor: const Color(0xFFFF4B26),
        foregroundColor: Colors.white,
      ),

      body: Obx(() {
        final pos = c.position.value;

        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              SwitchListTile(
                title: Text(
                  c.isGpsMode.value
                      ? "Mode: GPS (Akurasi Tinggi)"
                      : "Mode: NETWORK (Akurasi Rendah)",
                ),
                activeColor: Colors.orange,
                value: c.isGpsMode.value,
                onChanged: (_) => c.toggleMode(),
              ),

              const SizedBox(height: 20),

              pos == null
                  ? const Text(
                      "Menunggu lokasi...",
                      style: TextStyle(fontSize: 16),
                    )
                  : Column(
                      children: [
                        Text("Latitude: ${pos.latitude}"),
                        Text("Longitude: ${pos.longitude}"),
                        Text("Accuracy: ${c.accuracy.value} m"),
                        Text("Speed: ${c.speed.value} m/s"),
                        const SizedBox(height: 20),
                      ],
                    ),

              const Spacer(),

              ElevatedButton(
                onPressed: () => Get.to(() => LocationMapView()),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: const Text("Buka Peta & Tracking"),
              ),
            ],
          ),
        );
      }),
    );
  }
}
