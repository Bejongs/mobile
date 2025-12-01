import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../menu/views/menu_view.dart';
import '../../order/views/order_history_view.dart';
import '../../profil/views/profil_view.dart';

class MainController extends GetxController {
  var index = 0.obs;

  final pages = [
    const MenuView(),
    const OrderHistoryView(),
    const ProfilView(),
  ];
}

class MainView extends StatelessWidget {
  MainView({super.key});

  final MainController c = Get.put(MainController());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: IndexedStack(
          index: c.index.value,
          children: c.pages,
        ),

        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                offset: Offset(0, -2),
              )
            ],
          ),
          child: BottomNavigationBar(
            currentIndex: c.index.value,
            onTap: (i) => c.index.value = i,
            backgroundColor: Colors.white,
            selectedItemColor: const Color(0xFFFF4B26),
            unselectedItemColor: Colors.grey,

            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.restaurant_menu_rounded),
                label: "Menu",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.receipt_long_rounded),
                label: "Riwayat",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person_rounded),
                label: "Profil",
              ),
            ],
          ),
        ),
      );
    });
  }
}
