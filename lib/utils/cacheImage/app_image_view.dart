import 'dart:io';
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';

//ignore:must_be_immutable
class AppImageView extends StatelessWidget {
  final String imageUrl;
  var height = Get.height / 13;
  var width = Get.width / 4.7;

  AppImageView({
    super.key,
    required this.imageUrl,
    this.height = 40,
    this.width = 40,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: AppBorderRadius.BORDER_RADIUS_10,
      child: Image.network(
        imageUrl,
        errorBuilder:
            (BuildContext context, Object exception, StackTrace? stackTrace) {
          debugPrint(exception.toString());
          return Image.asset(
            AppImages.imagePlaceHolder,
            width: width,
            fit: BoxFit.cover,
            height: height,
          );
        },
        width: width,
        fit: BoxFit.cover,
        height: height,
      ),
    );
  }
}

//ignore:must_be_immutable
class AppCacheImageView extends StatelessWidget {
  AppCacheImageView(
      {super.key,
      required this.imageUrl,
      required this.width,
      required this.height,
      this.borderRadius = 10,
      this.isProfile = false});

  final String imageUrl;
  double width = Get.width * .3;
  double height = Get.height * .3;
  double borderRadius = 10;
  bool isProfile = false;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        width: width,
        height: height,
        fit: isProfile ? BoxFit.cover : BoxFit.contain,
        imageUrl: imageUrl.contains('http')
            ? imageUrl
            : HelperFunctions.getImageUrl(imageUrl),
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            margin: const EdgeInsets.all(2),
            child: customLoader(
              AppColors.PRIMARY_COLOR,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.logoJpg,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

//ignore:must_be_immutable
class AppProfileCacheImageView extends StatelessWidget {
  AppProfileCacheImageView({
    super.key,
    required this.imageUrl,
    required this.width,
    required this.height,
    this.borderRadius = 100,
  });

  final String imageUrl;
  double width = Get.width * .3;
  double height = Get.height * .3;
  double borderRadius = 10;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: CachedNetworkImage(
        height: height,
        width: width,
        fit: BoxFit.cover,
        imageUrl: imageUrl.contains('http')
            ? imageUrl
            : HelperFunctions.getImageUrl(imageUrl),
        progressIndicatorBuilder: (context, url, downloadProgress) => Center(
          child: Container(
            margin: const EdgeInsets.all(2),
            child: customLoader(
              AppColors.PRIMARY_COLOR,
            ),
          ),
        ),
        errorWidget: (context, url, error) => Image.asset(
          AppImages.imagePlaceHolder,
          fit: BoxFit.cover,
          height: height,
          width: width,
        ),
      ),
    );
  }
}

Widget customImage(
    {required String imageUrl,
    bool isProfile = true,
    double radius = 10,
    var width = 50.0,
    var height = 70.0,
    Color? color,
    Color? borderColor,
    BoxFit fit = BoxFit.cover}) {
  return Container(
    height: height,
    width: width,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(radius),
    ),
    child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.file(
          File(
            imageUrl,
          ),
          errorBuilder: (context, error, stackTrace) {
            return customLoader(AppColors.PRIMARY_COLOR);
          },
          fit: BoxFit.cover,
        )),
  );
}
