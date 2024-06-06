import 'dart:ui';

import 'package:ai_chatbot/utils/app_imports/app_imports.dart';


//ignore:must_be_immutable
class AppTextField extends StatefulWidget {
  String hint;
  String? intialvalue;
  TextEditingController controller;
  bool isPrefix;
  bool isSuffix;
  bool obscureText;
  bool isBoarder;
  Widget icon;
  Widget suffixIcon;
  int maxLines;
  int miniLines;
  double borderRadius;
  VoidCallback? onTap;
  TextInputType keyboardType;
  final ValueChanged<String>? onChanged;

  AppTextField({
    Key? key,
    this.hint = '',
    required this.controller,
    this.onChanged,
    this.borderRadius = 30.0,
    this.isPrefix = false,
    this.isSuffix = false,
    this.obscureText = false,
    this.isBoarder = true,
    this.onTap,
    this.maxLines = 1,
    this.miniLines = 1,
    this.icon = const SizedBox(),
    this.suffixIcon = const SizedBox(),
    this.keyboardType = TextInputType.text,
    this.intialvalue,
  }) : super(key: key);

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: TextFormField(
          controller: widget.controller,
          style: TextStyle(
            fontSize: 16,
            color: AppColors.BLACK,
          ),
          obscureText: widget.obscureText,
          initialValue: widget.intialvalue,
          maxLines: widget.maxLines,
          minLines: widget.miniLines,
          onTap: widget.onTap,
          autovalidateMode: AutovalidateMode.always,
          cursorColor: AppColors.PRIMARY_COLOR,
          onChanged: widget.onChanged,
          keyboardType: widget.keyboardType,
          decoration: InputDecoration(
              contentPadding:
                  const EdgeInsets.only(left: 16.0, top: 15, bottom: 15),
              suffixIcon: widget.isSuffix ? widget.suffixIcon : null,
              prefixIcon: widget.isPrefix ? widget.icon : null,
              enabledBorder:
              OutlineInputBorder(

                borderRadius: BorderRadius.circular(widget.borderRadius),
                borderSide:widget.isBoarder? BorderSide(color:AppColors.BLACK.withOpacity(0.4)):BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(widget.borderRadius),
                  borderSide:
                  widget.isBoarder?
                  BorderSide(
                      color: AppColors.PRIMARY_COLOR.withOpacity(.6)):BorderSide.none),
              filled: true,
              isDense: true,
              fillColor: Colors.transparent,
              hintText: widget.hint,
              hintStyle: TextStyle(
                  fontFamily: 'Sofia Sans',
                  fontWeight: FontWeight.w400,
                  fontSize: AppDimensions.FONT_SIZE_16,
                  color: AppColors.GRAY.withOpacity(.5))),
        ),
      ),
    );
  }
}
