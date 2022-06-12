import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final Function()? onTap;
  final bool readOnly;
  final bool obscureText;
  final int maxLines;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Function(String)? onChanged;
  final String? hintText;
  final String? errorText;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Color color;
  final Function()? onSuffixIconTap;

  const CustomTextField({
    Key? key,
    this.controller,
    this.onTap,
    this.readOnly = false,
    this.obscureText = false,
    this.maxLines = 1,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.hintText,
    this.errorText,
    this.prefixIcon,
    this.suffixIcon,
    this.color = Colors.white,
    this.onSuffixIconTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color outlineColor = primaryColor.withOpacity(.5);

    OutlineInputBorder outlineInputBorder = OutlineInputBorder(
      borderSide: BorderSide(
        color: outlineColor,
        width: 1,
      ),
      borderRadius: const BorderRadius.all(Radius.circular(6)),
    );

    return TextField(
      controller: controller,
      onTap: onTap,
      readOnly: readOnly,
      obscureText: obscureText,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      maxLines: maxLines,
      onChanged: onChanged,
      decoration: InputDecoration(
        enabledBorder: outlineInputBorder,
        focusedBorder: outlineInputBorder.copyWith(
          borderSide: BorderSide(
            color: outlineColor,
            width: 1.5,
          ),
        ),
        errorBorder: outlineInputBorder.copyWith(
          borderSide: const BorderSide(
            color: dangerColor,
          ),
        ),
        focusedErrorBorder: outlineInputBorder.copyWith(
          borderSide: const BorderSide(
            color: dangerColor,
            width: 1.5,
          ),
        ),
        hintText: hintText,
        hintStyle: primaryTextStyle.copyWith(
          color: primaryColor.withOpacity(.7),
          // color: secondaryColor.withOpacity(.8),
        ),
        errorText: errorText,
        errorMaxLines: 2,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon == null
            ? null
            : GestureDetector(
                onTap: onSuffixIconTap,
                child: suffixIcon,
              ),
      ),
    );
  }
}
