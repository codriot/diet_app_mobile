import 'package:diet_app_mobile/controller/main/main_controller.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_duration.dart';
import 'package:diet_app_mobile/views/discover/discover_view.dart';
import 'package:diet_app_mobile/views/home/home_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainView extends GetView<MainController> {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Scaffold(
        body: PageView(
          controller: controller.pageController,
          onPageChanged: (index) {
            controller.currentIndex.value = index;
          },
          physics: const BouncingScrollPhysics(), // Kaydırma animasyonu için
          children: [
            const HomeView(), // Ana sayfa
            DiscoverView(), // Keşfet sayfası
          ],
        ),
        bottomNavigationBar: AnimatedBottomNavigationBar(
          currentIndex: controller.currentIndex.value,
          onTap: controller.changeIndex,
        ),
      );
    });
  }
}

class AnimatedBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const AnimatedBottomNavigationBar({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColor.white.getColor(),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(36),
          bottomRight: Radius.circular(36),
        ),
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNavItem(Icons.home, 'Ana Sayfa', 0),
          _buildNavItem(Icons.search, 'Keşfet', 1),
          _buildNavItem(Icons.list, 'Diyetisyenler', 2),
          _buildNavItem(Icons.person, 'Profil', 3),
        ],
      ),
    );
  }

  Widget _buildNavItem(IconData icon, String label, int index) {
    final isSelected = currentIndex == index;

    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: AppDuration.instance.durationFast,
            padding: EdgeInsets.symmetric(vertical: isSelected ? 10 : 0),
            child: Icon(
              icon,
              color: isSelected
                  ? AppColor.vividBlue.getColor()
                  : AppColor.black.getColor(),
            ),
          ),
          AnimatedContainer(
            duration: AppDuration.instance.durationFast,
            child: Text(
              label,
              style: TextStyle(
                color: isSelected
                    ? AppColor.vividBlue.getColor()
                    : AppColor.black.getColor(),
                fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
