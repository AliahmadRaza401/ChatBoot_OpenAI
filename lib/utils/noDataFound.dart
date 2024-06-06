import 'package:ai_chatbot/utils/app_imports/app_imports.dart';

nodDataFound() {
  return Row(
    mainAxisAlignment:
    MainAxisAlignment.center,
    children: [
      Column(
        crossAxisAlignment:
        CrossAxisAlignment.center,
        mainAxisAlignment:
        MainAxisAlignment.center,
        children: [
          Image.asset(
            AppImages.logoJpg,
            height: 200,
            width: 200,
          ),
          AppText(
              text:
              "Pas de données disponibles",
              fontWeight: FontWeight.w700,
              size: AppDimensions.FONT_SIZE_16,
              color: AppColors.beautyServiceTextColor,
              fontFamily: 'Plus Jakarta Sans',
              textAlign: TextAlign.center
          )
        ],
      ),
    ],
  );
}