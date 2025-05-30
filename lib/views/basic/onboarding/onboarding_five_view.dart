import 'package:diet_app_mobile/controller/basic/global_onboarding_controller.dart';
import 'package:diet_app_mobile/controller/basic/onboarding/onboarding_five_controller.dart';
import 'package:diet_app_mobile/model/onboarding/onboarding_selection_card_model.dart';
import 'package:diet_app_mobile/product/navigator/navigate_route_items.dart';
import 'package:diet_app_mobile/product/navigator/navigator_controller.dart';
import 'package:diet_app_mobile/product/services/icon_and_image_services.dart';
import 'package:diet_app_mobile/product/utils/app_utils/app_general.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_colors.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_padding.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_radius.dart';
import 'package:diet_app_mobile/product/utils/app_utils/const_utils/app_sizes.dart';
import 'package:diet_app_mobile/product/widgets/general/custom_elevated_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_page_button.dart';
import 'package:diet_app_mobile/product/widgets/general/general_shadow_components.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_page_circle.dart';
import 'package:diet_app_mobile/product/widgets/onboarding/onboarding_top_components.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class OnboardingFiveView extends StatelessWidget {
  OnboardingFiveView({super.key});
  final GlobalOnboardingController globalOnboardingController =
      Get.find<GlobalOnboardingController>();

  final OnboardingFiveController controller =
      Get.find<OnboardingFiveController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            OnboardingTopComponents(
              title: "Ne Yemeyi Daha Çok Seversiniz?",
              textPadding: AppPadding.instance.horizontalLarge,
            ),
            Expanded(
              child: Padding(
                  padding: AppPadding.instance.horizontalMedium,
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, // Her satırda 3 öğe olacak
                      crossAxisSpacing:
                          AppSizes.instance.mediumValue, // Yatay boşluk
                      mainAxisSpacing:
                          AppSizes.instance.mediumValue, // Dikey boşluk
                    ),
                    itemCount: controller.onboardingSelectionCardModelFood
                        .length, // Liste eleman sayısı kadar oluşturur
                    shrinkWrap: true, // GridView'ı içeriğe göre küçült
                    physics:
                        const NeverScrollableScrollPhysics(), // Kaydırmayı devre dışı bırak
                    padding: EdgeInsets.symmetric(
                      vertical: AppSizes.instance.mediumValue,
                    ), // Dış boşluklar
                    itemBuilder: (context, index) {
                      final OnboardingSelectionCardModel model =
                          controller.onboardingSelectionCardModelFood[index];
                      return _buildFoodOptionContainer(
                        index: index,
                        context: context,
                        icon: model.icon,
                        title: model.title,
                      );
                    },
                  )),
            ),
            GeneralOnboardingPageCircleComponent(),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(
                      OnboardingPageCountEnum.onboardingPageSix.index);
                  NavigatorController.instance
                      .pushToPage(NavigateRoutesItems.onboardingSix);
                },
                text: "Next",
                padding: AppPadding.instance.bottomNormal,
                isIconActive: true,
              ),
            ),
            Padding(
              padding: AppPadding.instance.horizontalMedium,
              child: GeneralPageButtonWidget(
                onPressed: () {
                  globalOnboardingController.toggleOnboardingPageCount(
                      OnboardingPageCountEnum.onboardingPageSix.index);
                  NavigatorController.instance
                      .pushToPage(NavigateRoutesItems.onboardingSix);
                },
                text: "Skip",
                padding: AppPadding.instance.bottomNormal,
                backgroundColor: AppColor.sweetPatato.getColor(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Obx _buildFoodOptionContainer(
      {required BuildContext context,
      required String icon,
      required String title,
      required int index}) {
    return Obx(
      () => CustomElevatedButton(
        elevation: 0,
        shape: RoundedRectangleBorder(
            borderRadius: AppRadius.instance.largeBorderRadius),
        onPressed: () {
          controller.toggleSelection(index);
        },
        child: Container(
          width: 110,
          height: 120,
          decoration: BoxDecoration(
              color: AppColor.crystalBell.getColor(),
              borderRadius: AppRadius.instance.largeBorderRadius,
              boxShadow: [generalComponentsShadow()],
              border: Border.all(
                color: controller.isActiveList[index]
                    ? AppColor.vividBlue.getColor()
                    : AppColor.crystalBell.getColor(),
                width: 2,
              )),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SvgPicture.asset(
                  AppIconUtility.getIconPath(icon, format: IconFormat.svg)),
              Padding(
                padding: AppPadding.instance.topSmall,
                child: Text(
                  title,
                  style: context.appGeneral.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
