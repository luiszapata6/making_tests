import 'package:flutter/material.dart';
import '../../../presentation.dart';

class LargeButton extends StatelessWidget {
  const LargeButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.fontSize,
    this.width,
    this.height,
    this.icon,
    this.color,
    this.textColor,
    this.borderColor,
  }) : super(key: key);

  final String text;
  final Function() onPressed;
  final double? width;
  final double? height;
  final double? fontSize;
  final String? icon;
  final Color? color;
  final Color? textColor;
  final Color? borderColor;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onPressed,
      child: Ink(
        height: height ?? size.height * 0.0566,
        width: width,
        decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? purple,
          ),
          color: color ?? purple,
          borderRadius: BorderRadius.circular(7),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextPoppins(
                fontSize: fontSize ?? 18,
                text: text,
                color: textColor ?? white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
