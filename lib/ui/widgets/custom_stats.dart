import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_color.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomStats extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  final Color backgroundColor;

  const CustomStats({
    Key? key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.color = primaryColor,
    this.backgroundColor = greyThirdColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Adaptive.w(100 / 4),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(
          Radius.circular(
            16,
          ),
        ),
        color: backgroundColor,
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: color,
            child: Center(
              child: Icon(
                icon,
                color: Colors.white,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  title,
                  style: boldTextStyle.copyWith(fontSize: 20),
                ),
                const SizedBox(height: 8),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
