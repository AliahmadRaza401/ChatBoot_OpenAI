

import 'package:ai_chatbot/utils/app_imports/app_imports.dart';

Widget vSizedBox(
    {double height=15}) {
  return SizedBox(
    height: height,
  );
}

Widget hSizedBox(
    { double width=15}) {
  return SizedBox(
    width:  width,
  );
}

Widget appDivider({ double? height}) {
  return Container(
    height: height != null ? Get.height / height : Get.height / 57,
    width: Get.width,
    color: AppColors.GRAY.withOpacity(.2),
  );
}
