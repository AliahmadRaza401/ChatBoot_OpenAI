// ignore_for_file: prefer_const_constructors, must_be_immutable, prefer_const_literals_to_create_immutables
import 'package:ai_chatbot/utils/app_imports/app_imports.dart';


class PrimaryAppBar extends StatelessWidget {
  final Color appbarColor;
  final bool isSubTitle;
  final bool isPrefix;
  final String titleFontFamily;
  final String subTitleFontFamily;
  final bool isDrop;
  final bool isOnSubTitle;
  final bool isSuffix;
  final String subTitle;
  final VoidCallback? dropOnTap;
  final Color prefixIconColor;
  final Color suffixIconColor;
  final Color prefixButtonColor;
  final Color suffixButtonColor;
  final Color dropDownIconColor;
  final String suffixIconImage;
  final String prefixIconImage;
  final String titleText;
  final bool isCenter;
  final double titleSize;
  final double suffixPadding;
  final double prefixPadding;
  double subtitleSize;
  final Color titleColor;
  final Color subtitleColor;
  List<Widget> actions;
  final bool isActions;
  final FontWeight titleFontWeight;
  final FontWeight subtitleFontWeight;
  final VoidCallback? prefixOnTap;
  final VoidCallback? suffixOnTap;
  final bool isDivider;
  final double prefixIconHeight;
  final double prefixIconWidth;
  final double suffixIconHeight;
  final double suffixIconWidth;

  PrimaryAppBar({
    Key? key,
    this.suffixIconImage = "assets/images/email.png",
    this.prefixIconImage = "assets/images/menu.png",
    required this.titleText,
    this.prefixOnTap,
    this.suffixOnTap,
    this.prefixIconColor = Colors.black,
    this.suffixIconColor = Colors.black,
    this.isSubTitle = false,
    this.isDrop = false,
    this.subTitle = "",
    this.actions = const [],
    this.isActions = false,
    this.dropOnTap,
    this.isSuffix = true,
    this.isPrefix = true,
    this.titleSize = 18,
    this.subtitleSize = 18,
    this.titleColor = Colors.black,
    this.subtitleColor = Colors.grey,
    this.titleFontWeight = FontWeight.w400,
    this.subtitleFontWeight = FontWeight.w400,
    this.prefixButtonColor = const Color(0xffE5E5E5),
    this.suffixButtonColor = const Color(0xffE5E5E5),
    this.dropDownIconColor = const Color(0xffE5E5E5),
    this.isDivider = true,
    this.isCenter = false,
    this.titleFontFamily = "Poppins",
    this.subTitleFontFamily = "Poppins",
    this.isOnSubTitle = false,
    this.suffixPadding = 5,
    this.prefixPadding = 5,
    this.prefixIconHeight = 18,
    this.prefixIconWidth = 18,
    this.suffixIconHeight = 18,
    this.suffixIconWidth = 18,
    this.appbarColor = Colors.white,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: appbarColor,
      // height: Get.height / 8.12,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 40,bottom: 10,left: 16,right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                isPrefix
                    ? Row(
                       mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          GestureDetector(
                            onTap: prefixOnTap ?? () {},
                            child: CircleAvatar(
                              radius:18,
                              backgroundColor: AppColors.TRANSPARENT_COLOR,
                              child: Image.asset(
                                height: prefixIconHeight,
                                width: prefixIconWidth,
                                prefixIconImage,
                                color: prefixIconColor,
                              ),
                            ),
                          ),
                          // AppCircleImageButton(
                          //   imageUrl: prefixIconImage,
                          //   onTap: prefixOnTap ?? () {},
                          //   iconColor: prefixIconColor,
                          //   padding: prefixPadding,
                          //   buttonColor: prefixButtonColor,
                          //   height: prefixIconHeight,
                          //   width: prefixIconWidth,
                          // ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      )
                    : Container(),
                isCenter ? Spacer() : Container(),
                isSubTitle
                    ? GestureDetector(
                        onTap: dropOnTap ?? () {},
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            GestureDetector(
                              onTap: dropOnTap ?? () {},
                              child: Row(
                                children: [
                                  AppText(
                                      fontFamily: titleFontFamily,
                                      text: titleText,
                                      size: titleSize,
                                      color: titleColor,
                                      fontWeight: titleFontWeight),
                                  isOnSubTitle
                                      ? Container()
                                      : Row(
                                          children: [
                                            SizedBox(width: 100),
                                            Image(
                                              height:
                                                  AppDimensions.FONT_SIZE_15,
                                              color: dropDownIconColor,
                                              image: AssetImage(
                                                'assets/icons/down_arrow.png',
                                              ),
                                            ),
                                          ],
                                        )
                                ],
                              ),
                            ),
                            // verticalSizedBox(context: context, height: 200),
                            Row(
                              children: [
                                AppText(
                                    fontFamily: subTitleFontFamily,
                                    text: subTitle,
                                    size: subtitleSize,
                                    color: subtitleColor,
                                    fontWeight: subtitleFontWeight),
                                isOnSubTitle
                                    ? Row(
                                        children: [
                                          SizedBox(width: 100),
                                          Image(
                                            height: AppDimensions.FONT_SIZE_15,
                                            color: dropDownIconColor,
                                            image: AssetImage(
                                              'assets/icons/down_arrow.png',
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container()
                              ],
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: AppText(
                            fontFamily: titleFontFamily,
                            text: titleText,
                            size: titleSize,
                            color: titleColor,
                            fontWeight: titleFontWeight),
                      ),
                const Spacer(),
                isSuffix
                    ? AppCircleImageButton(
                        imageUrl: suffixIconImage,
                        onTap: suffixOnTap ?? () {},
                        iconColor: suffixIconColor,
                        padding: suffixPadding,
                        buttonColor: suffixButtonColor,
                        height: suffixIconHeight,
                        width: suffixIconWidth,
                      )
                    : isActions
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: actions,
                          )
                        : Container(),
              ],
            ),
          ),
          isDivider
              ? const Divider(
                  height: 0,
                )
              : SizedBox.shrink()
        ],
      ),
    );
  }
}

class AppCircleImageButton extends StatelessWidget {
  final Color iconColor;
  final Color buttonColor;
  final double height;
  final double width;
  final double padding;
  final String imageUrl;
  final VoidCallback onTap;

  const AppCircleImageButton(
      {Key? key,
      this.buttonColor = const Color(0xffE5E5E5),
      this.height = 36,
      this.width = 36,
      required this.imageUrl,
      required this.onTap,
      required this.iconColor,
      this.padding = 5})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        decoration: BoxDecoration(color: buttonColor, shape: BoxShape.circle),
        child: Padding(
            padding: EdgeInsets.all(padding),
            child: Image(
              image: AssetImage(imageUrl),
              color: iconColor,
            )),
      ),
    );
  }
}
