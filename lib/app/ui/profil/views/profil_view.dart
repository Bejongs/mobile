import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/theme/theme_controller.dart';
import '../controllers/profil_controller.dart';

class ProfilView extends StatelessWidget {
  const ProfilView({super.key});

  @override
  Widget build(BuildContext context) {
    final pC = Get.find<ProfilController>();
    final tC = Get.find<ThemeController>();

    return Scaffold(
      backgroundColor: const Color(0xFFFFF8F4),

      appBar: AppBar(
        title: const Text(
          'Profil',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFFF4B26),
        foregroundColor: Colors.white,
        elevation: 0,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
        child: Column(
          children: [

            // =====================================================================
            // PROFILE CARD (Foto + Nama) ala GoFood
            // =====================================================================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  )
                ],
              ),
              child: Column(
                children: const [
                  CircleAvatar(
                    radius: 48,
                    backgroundColor: Color(0xFFFFEDE7),
                    child: Icon(
                      Icons.person_rounded,
                      size: 60,
                      color: Color(0xFFFF4B26),
                    ),
                  ),
                  SizedBox(height: 14),
                  Text(
                    "Pengguna Dimsum",
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF333333),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // =====================================================================
            // SETTINGS LIST (Dark mode)
            // =====================================================================
            buildSectionTitle("Pengaturan"),
            const SizedBox(height: 10),

            buildSettingTile(
              icon: Icons.dark_mode_rounded,
              title: "Dark Mode",
              trailing: Obx(() {
                return Switch(
                  activeColor: const Color(0xFFFF4B26),
                  value: tC.isDark.value,
                  onChanged: (_) => tC.toggleTheme(),
                );
              }),
              onTap: () => tC.toggleTheme(),
            ),

            const SizedBox(height: 28),

            // =====================================================================
            // RIWAYAT PESANAN
            // =====================================================================
            buildSectionTitle("Riwayat Pesanan"),
            const SizedBox(height: 10),

            Obx(() {
              if (pC.isLoading.value) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.only(top: 20),
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (pC.orders.isEmpty) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    "Belum ada pesanan.",
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                );
              }

              return Column(
                children: pC.orders.map((order) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(14),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 3),
                        )
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Pesanan #${order.id}",
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "Rp ${order.total}",
                          style: const TextStyle(
                            fontSize: 15,
                            color: Color(0xFFFF4B26),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              );
            }),

            const SizedBox(height: 28),

            // =====================================================================
            // MODUL 3 BUTTON
            // =====================================================================
            buildSectionTitle("Tugas Tambahan"),
            const SizedBox(height: 12),

            buildNavigationTile(
              icon: Icons.api_rounded,
              title: "Modul 3 – API Test",
              onTap: () => Get.toNamed('/api-test'),
            ),

            buildNavigationTile(
              icon: Icons.location_on_rounded,
              title: "Modul 5 – Location",
              onTap: () => Get.toNamed('/location'),
            ),

            const SizedBox(height: 30),

            // =====================================================================
            // LOGOUT BUTTON
            // =====================================================================
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                onPressed: () => pC.logout(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  "Logout",
                  style: TextStyle(
                    fontSize: 17,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // =====================================================================
  // WIDGET HELPERS (bersih & reusable)
  // =====================================================================

  Widget buildSectionTitle(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget buildSettingTile({
    required IconData icon,
    required String title,
    required Widget trailing,
    void Function()? onTap,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: _tileDecoration(),
      child: Row(
        children: [
          Icon(icon, color: const Color(0xFFFF4B26), size: 28),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget buildNavigationTile({
    required IconData icon,
    required String title,
    void Function()? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
      decoration: _tileDecoration(),
      child: ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(icon, color: const Color(0xFFFF4B26), size: 30),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        trailing: const Icon(Icons.chevron_right_rounded, color: Colors.black45),
        onTap: onTap,
      ),
    );
  }

  BoxDecoration _tileDecoration() {
    return BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withOpacity(0.05),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    );
  }
}
