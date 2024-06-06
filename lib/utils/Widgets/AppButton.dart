// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:get/get.dart';
import 'AppText.dart';

//ignore:must_be_immutable
class AppButton extends StatelessWidget {
  final String buttonName;
  final double textSize;
  final double buttonWidth;
  final double buttonHeight;
  final Color buttonColor;
  final Color textColor;
  final Color iconColor;
  final FontWeight fontWeight;
  final BorderRadius buttonRadius;
  final IconData icon;
  final String iconImage;
  final bool isIcon;
  final bool isCenter;
  final double iconSize;
  final double iconWidth;
  final double iconHight;
  final double paddingButton;
  final VoidCallback onTap;
  final double borderWidth;
  final Color borderColor;
  final Color imageIconColor;
  final String fontFamily;
  bool isSuffix = false;
  double elevation = 3.0;

  AppButton({
    Key? key,
    required this.buttonName,
    this.buttonWidth = 250,
    this.buttonHeight = 50,
    required this.buttonColor,
    required this.textColor,
    this.fontWeight = FontWeight.normal,
    this.buttonRadius = BorderRadius.zero,
    this.iconColor = Colors.white,
    this.icon = Icons.home,
    this.iconImage = "",
    this.imageIconColor = Colors.transparent,
    this.isIcon = false,
    this.isCenter = false,
    this.iconSize = 30,
    this.iconWidth = 21,
    this.iconHight = 14,
    this.paddingButton = 0,
    this.fontFamily = "Poppins",
    required this.onTap,
    this.textSize = 15,
    this.borderWidth = 0,
    this.elevation = 3.0,
    this.isSuffix = false,
    this.borderColor = Colors.transparent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetPlatform.isAndroid
        ? Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
                borderRadius: buttonRadius,
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                )),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: buttonColor,
                textStyle: TextStyle(
                    color: textColor,
                    fontFamily: fontFamily,
                    fontWeight: fontWeight,
                    fontSize: textSize),
                padding: EdgeInsets.zero,
                shape: RoundedRectangleBorder(borderRadius: buttonRadius),
                elevation: elevation,
              ),
              onPressed: onTap,
              child: Padding(
                padding: isCenter
                    ? const EdgeInsets.symmetric(horizontal: 20)
                    : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
                child: Row(
                  mainAxisAlignment: paddingButton == 0
                      ? MainAxisAlignment.center
                      : MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    !isSuffix
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    color: iconColor,
                                    size: iconSize,
                                  )
                                : Image.asset(
                                    iconImage,
                                    height: iconSize,
                                    color: imageIconColor,
                                  )
                            : Container()
                        : Container(),
                    isCenter
                        ? const Spacer()
                        : SizedBox(
                            width: paddingButton == 0
                                ? isIcon
                                    ? 10
                                    : 0
                                : paddingButton,
                          ),
                    isSuffix
                        ? Container(
                            width: Get.width * 0.6,
                            child: Center(
                              child: AppText(
                                  text: buttonName,
                                  color: textColor,
                                  fontFamily: fontFamily,
                                  fontWeight: fontWeight,
                                  size: textSize),
                            ),
                          )
                        : Center(
                            child: AppText(
                                text: buttonName,
                                color: textColor,
                                fontFamily: fontFamily,
                                fontWeight: fontWeight,
                                size: textSize),
                          ),
                    isCenter ? const Spacer() : Container(),
                    isCenter
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    color: iconColor,
                                    size: iconSize,
                                  )
                                : Image.asset(iconImage,
                                    height: iconWidth,
                                    color: Colors.transparent)
                            : Container()
                        : Container(),
                    isSuffix
                        ? isIcon
                            ? iconImage == ""
                                ? Icon(
                                    icon,
                                    color: iconColor,
                                    size: iconSize,
                                  )
                                : Row(
                                    children: [
                                      Image.asset(
                                        iconImage,
                                        width: iconWidth,
                                        height: iconHight,
                                        color: iconColor,
                                      ),
                                    ],
                                  )
                            : Container()
                        : Container(),
                  ],
                ),
              ),
            ),
          )
        : Container(
            height: buttonHeight,
            width: buttonWidth,
            decoration: BoxDecoration(
                color: buttonColor,
                borderRadius: buttonRadius,
                border: Border.all(
                  width: borderWidth,
                  color: borderColor,
                )),
            child: CupertinoButton(
              borderRadius: buttonRadius,
              padding: EdgeInsets.zero,
              color: buttonColor,
              onPressed: onTap,
              child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                  ),
                  // height: ,
                  child: Padding(
                    padding: isCenter
                        ? const EdgeInsets.symmetric(horizontal: 20)
                        : EdgeInsets.only(left: paddingButton == 0 ? 0 : 15),
                    child: Row(
                      mainAxisAlignment: paddingButton == 0
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        !isSuffix
                            ? isIcon
                                ? iconImage == ""
                                    ? Icon(
                                        icon,
                                        color: iconColor,
                                        size: iconSize,
                                      )
                                    : Image.asset(
                                        iconImage,
                                        height: iconSize,
                                      )
                                : Container()
                            : Container(),
                        isCenter
                            ? const Spacer()
                            : SizedBox(
                                width: paddingButton == 0
                                    ? isIcon
                                        ? 10
                                        : 0
                                    : paddingButton,
                              ),
                        isSuffix
                            ? Container(
                                width: Get.width * 0.6,
                                child: Center(
                                  child: AppText(
                                      text: buttonName,
                                      color: textColor,
                                      fontFamily: fontFamily,
                                      fontWeight: fontWeight,
                                      size: textSize),
                                ),
                              )
                            : Center(
                                child: AppText(
                                    text: buttonName,
                                    color: textColor,
                                    fontFamily: fontFamily,
                                    fontWeight: fontWeight,
                                    size: textSize),
                              ),
                        isCenter ? const Spacer() : Container(),
                        isCenter
                            ? isIcon
                                ? iconImage == ""
                                    ? Icon(
                                        icon,
                                        color: iconColor,
                                        size: iconSize,
                                      )
                                    : Image.asset(iconImage,
                                        height: iconSize,
                                        color: Colors.transparent)
                                : Container()
                            : Container(),
                        isSuffix
                            ? isIcon
                                ? iconImage == ""
                                    ? Icon(
                                        icon,
                                        color: iconColor,
                                        size: iconSize,
                                      )
                                    : Row(
                                        children: [
                                          Image.asset(
                                            iconImage,
                                            width: iconWidth,
                                            height: iconHight,
                                            color: iconColor,
                                          ),
                                        ],
                                      )
                                : Container()
                            : Container(),
                      ],
                    ),
                  )),
            ));
  }
}
