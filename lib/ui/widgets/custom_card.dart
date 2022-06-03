import 'package:flutter/material.dart';
import 'package:pencarian_jurnal/theme/app_text.dart';

class CustomCard extends StatelessWidget {
  final Color color;
  final String? title;
  final TextStyle titleStyle;
  final String? subtitle;
  final TextStyle subtitleStyle;
  final Widget child;
  final bool childExpanded;
  final double? height;
  final double width;

  const CustomCard({
    Key? key,
    this.color = Colors.white,
    this.title,
    this.titleStyle = kHeaderTextStyle,
    this.subtitle,
    this.subtitleStyle = kSubtitleTextStyle,
    required this.child,
    this.childExpanded = false,
    this.height,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      decoration: BoxDecoration(
        color: color,
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (title != null) ...[
            Text(
              title!,
              style: titleStyle,
            ),
            const SizedBox(height: 8),
          ],
          if (subtitle != null) ...[
            Text(
              subtitle!,
              style: subtitleStyle,
            ),
            const SizedBox(height: 16),
          ],
          if (!childExpanded) child,
          if (childExpanded) Flexible(child: child),
        ],
      ),
    );
  }
}
