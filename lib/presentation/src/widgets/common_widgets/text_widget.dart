import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextPoppins extends StatelessWidget {
  const TextPoppins({
    Key? key,
    required this.text,
    this.maxLines,
    this.color,
    this.textAlign,
    this.fontWeight,
    this.fontSize,
  }) : super(key: key);

  final String text;
  final int? maxLines;
  final Color? color;
  final TextAlign? textAlign;
  final FontWeight? fontWeight;
  final double? fontSize;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.poppins(
        textStyle: TextStyle(
            fontWeight: fontWeight ?? FontWeight.w700,
            fontSize: fontSize ?? 14,
            color: color ?? Colors.white),
      ),
      overflow: TextOverflow.ellipsis,
      softWrap: false,
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
    );
  }
}
