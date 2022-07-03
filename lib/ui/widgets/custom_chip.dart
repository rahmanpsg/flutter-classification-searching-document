import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';

class CustomChip extends StatelessWidget {
  final String text;
  final Color color;
  final Color textColor;
  final double width;
  final Function() onTap;
  final bool isActive;

  const CustomChip({
    Key? key,
    required this.text,
    required this.color,
    this.textColor = Colors.white,
    this.width = 100,
    required this.onTap,
    required this.isActive,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: isActive ? Colors.black : Colors.transparent,
          width: 2,
        ),
      ),
      color: color,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(15),
        child: SizedBox(
          width: width,
          child: Center(
            child: Text(
              text,
              style: primaryTextStyle.copyWith(color: textColor),
            ),
          ),
        ),
      ),
    );
  }
}
