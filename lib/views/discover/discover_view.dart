// lib/views/discover/discover_view.dart
import 'package:diet_app_mobile/controller/discover/discover_controller.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_spaces..dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DiscoverView extends GetView<DiscoverController> {
  const DiscoverView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.whiteSolid.getColor(),
      appBar: _buildAppBar(context),
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
          controller.makeMenuOpenVal();
        },
        child: Stack(
          children: [
            Padding(
              padding: AppPadding.instance.horizontalNormal,
              child: Obx(() {
                return NotificationListener<ScrollNotification>(
                  onNotification: controller.onNotification,
                  child: ListView(
                    children: [
                      _buildPageGridViewBuilder(),
                      if (controller.isLoading.value)
                        _buildPageCircleProgressBar(),
                    ],
                  ),
                );
              }),
            ),
            _buildFilterDiscoverItems(context),
          ],
        ),
      ),
    );
  }

  Positioned _buildFilterDiscoverItems(BuildContext context) {
    return Positioned(
      right: AppSizes.instance.normalValue,
      child: Obx(
        () => AnimatedSize(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Container(
            width: Get.width * 0.56,
            height: controller.isMenuOpen.value ? Get.height * 0.16 : 0,
            decoration: BoxDecoration(
              color: AppColor.black.getColor().withAlpha(200),
              borderRadius: AppRadius.instance.normalBorderRadius,
            ),
            child: controller.isMenuOpen.value
                ? ClipRRect(
                    borderRadius: AppRadius.instance.normalBorderRadius,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          "Önerilen Filtreleme",
                          style: context.appGeneral.textTheme.bodyMedium
                              ?.copyWith(color: AppColor.white.getColor()),
                        ),
                        _buildFilterButtonComponent(
                          context: context,
                          isActive: controller.activeFilterIndex.value == 0,
                          text: "Senin için",
                          trailingIcon: "account-circle-line",
                          index: 0,
                        ),
                        _buildFilterButtonComponent(
                          context: context,
                          isActive: controller.activeFilterIndex.value == 1,
                          text: "Kişileştirilmemiş",
                          trailingIcon: "earth-line",
                          index: 1,
                        ),
                      ],
                    ),
                  )
                : const SizedBox(),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButtonComponent({
    required BuildContext context,
    required String text,
    required String trailingIcon,
    required bool isActive,
    required int index,
  }) {
    return CustomElevatedButton(
      onPressed: () {
        controller.toggleFilter(index);
      },
      elevation: 0,
      backgroundColor: AppColor.transparent.getColor(),
      width: double.infinity,
      child: Padding(
        padding: AppPadding.instance.topSmall,
        child: Row(
          children: [
            isActive
                ? SvgPicture.asset(
                    AppIconUtility.getIconPath("check-line",
                        format: IconFormat.svg),
                    color: AppColor.white.getColor(),
                  )
                : const SizedBox(width: 24),
            AppSpaces.instance.horizontal10,
            Text(
              text,
              style: context.appGeneral.textTheme.bodyLarge?.copyWith(
                  color: AppColor.white.getColor(),
                  fontWeight: FontWeight.w500),
            ),
            AppSpaces.instance.space,
            SvgPicture.asset(
              AppIconUtility.getIconPath(trailingIcon, format: IconFormat.svg),
              color: AppColor.white.getColor(),
            ),
          ],
        ),
      ),
    );
  }

  GridView _buildPageGridViewBuilder() {
    return GridView.builder(
      padding: AppPadding.instance.verticalNormal,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: controller.items.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            NavigatorController.instance.pushToPage(
                NavigateRoutesItems.discoverDetail,
                arguments: controller.items[index]);
          },
          child: Container(
            margin: const EdgeInsets.all(1),
            decoration: BoxDecoration(
              color: AppColor.orochimaru.getColor(),
              borderRadius: AppRadius.instance.normalBorderRadius,
              boxShadow: [
                BoxShadow(
                    blurRadius: 1,
                    spreadRadius: 1,
                    color: AppColor.black12.getColor())
              ],
              image: DecorationImage(
                  image: NetworkImage(controller.items[index].imageUrl),
                  fit: BoxFit.cover),
            ),
          ),
        );
      },
    );
  }

  Padding _buildPageCircleProgressBar() {
    return Padding(
      padding: AppPadding.instance.bottomNormal,
      child: const SizedBox(
        height: 56,
        width: double.infinity,
        child: Center(
          child: CircularProgressIndicator(),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      elevation: 0,
      backgroundColor: AppColor.transparent.getColor(),
      automaticallyImplyLeading: false,
      title: CustomTextField(
        hintText: "Arama yapın",
        controller: controller.discoverTextEditingController,
        showSearchIcon: true,
        height: 40,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Lütfen bir değer girin';
          }
          return null;
        },
        onSubmit: (value) {
          FocusScope.of(context).unfocus();
        },
        onChange: (String? query) {
          controller.searchItems(query ?? "");
        },
        suffix: Obx(
          () => controller.searchText.isNotEmpty
              ? Positioned(
                  right: 8,
                  top: 8,
                  child: InkWell(
                    onTap: controller.clearSearch,
                    borderRadius: AppRadius.instance.largeBorderRadius,
                    child: SvgPicture.asset(AppIconUtility.getIconPath("close",
                        format: IconFormat.svg)),
                  ),
                )
              : const SizedBox(),
        ),
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 20, top: 8),
          child: CustomElevatedButton(
            backgroundColor: AppColor.transparent.getColor(),
            elevation: 0,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            height: 40,
            width: 40,
            child: SvgPicture.asset(
              AppIconUtility.getIconPath("more", format: IconFormat.svg),
            ),
            onPressed: () {
              controller.toggleMenuOpen();
            },
          ),
        ),
      ],
    );
  }
}
