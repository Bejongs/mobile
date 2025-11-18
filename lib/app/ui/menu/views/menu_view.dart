import 'package:flutter/material.dart' hide MenuController;
import 'package:get/get.dart';
import '../controllers/menu_controller.dart' as menu_ctrl;
import 'package:demo_modul4/app/ui/login/controllers/login_controller.dart';


class MenuView extends StatelessWidget {
  const MenuView({super.key});

  menu_ctrl.MenuController get c => Get.find<menu_ctrl.MenuController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu Dimsum'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              final loginC = Get.find<LoginController>();
              loginC.logout();
            },
          ),
        ],
      ),

      body: Obx(() {
        if (c.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (c.menus.isEmpty) {
          return const Center(child: Text('Menu belum tersedia'));
        }

        return ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount: c.menus.length,
          itemBuilder: (_, i) {
            final m = c.menus[i];
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: m.imageUrl.isNotEmpty
                          ? Image.network(
                              m.imageUrl,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (ctx, err, st) => Container(
                                width: 64,
                                height: 64,
                                color: Colors.grey[300],
                                child: const Icon(Icons.image_not_supported),
                              ),
                            )
                          : Container(width: 64, height: 64, color: Colors.grey[300]),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(m.name, style: Theme.of(context).textTheme.titleMedium),
                          const SizedBox(height: 6),
                          Text(m.description, maxLines: 3, overflow: TextOverflow.ellipsis),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    SizedBox(
                      width: 100,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text('Rp ${m.price}', style: Theme.of(context).textTheme.bodySmall),
                          const SizedBox(height: 8),
                          SizedBox(
                            height: 36,
                            child: ElevatedButton(
                              onPressed: () => c.addToCart(m),
                              child: const Text('Tambah', style: TextStyle(fontSize: 12)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }),
    );
  }
}
