import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/api_test_controller.dart';

class ApiTestView extends StatelessWidget {
  ApiTestView({super.key});

  final ApiTestController c = Get.find<ApiTestController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),

      appBar: AppBar(
        title: const Text(
          "Modul 3 - API Test",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        foregroundColor: Colors.white,
        backgroundColor: const Color(0xFFFF4B26),
        elevation: 0,
      ),

      body: Obx(() {
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =======================================================
              // TITLE
              // =======================================================
              const Text(
                "Perbandingan HTTP & DIO",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF222222),
                ),
              ),

              const SizedBox(height: 16),

              // =======================================================
              // TOMBOL HTTP
              // =======================================================
              ElevatedButton(
                onPressed: c.isLoading.value ? null : c.testHttp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF4B26),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Test API dengan HTTP",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 12),

              // =======================================================
              // TOMBOL DIO
              // =======================================================
              ElevatedButton(
                onPressed: c.isLoading.value ? null : c.testDio,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black87,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                ),
                child: const Text(
                  "Test API dengan DIO",
                  style: TextStyle(fontSize: 16),
                ),
              ),

              const SizedBox(height: 25),

              // =======================================================
              // LOADING
              // =======================================================
              if (c.isLoading.value)
                const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(
                      color: Color(0xFFFF4B26),
                    ),
                  ),
                ),

              // =======================================================
              // HASIL HTTP
              // =======================================================
              if (!c.isLoading.value && c.resultHttp.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hasil HTTP",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        c.resultHttp.value,
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Waktu: ${c.timeHttp.value} ms",
                        style: const TextStyle(
                          color: Color(0xFFFF4B26),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              // =======================================================
              // HASIL DIO
              // =======================================================
              if (!c.isLoading.value && c.resultDio.isNotEmpty)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.orange.withOpacity(0.12),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Hasil DIO",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Text(
                        c.resultDio.value,
                        style: const TextStyle(fontSize: 14),
                      ),

                      const SizedBox(height: 12),

                      Text(
                        "Waktu: ${c.timeDio.value} ms",
                        style: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),

              const SizedBox(height: 30),
            ],
          ),
        );
      }),
    );
  }
}
