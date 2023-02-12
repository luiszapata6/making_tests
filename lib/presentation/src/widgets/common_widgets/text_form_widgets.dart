import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../presentation.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.controller,
    this.validator,
    this.obscureText,
    this.suffixIcon,
    this.keyboardType,
    this.inputFormatters,
    this.height,
    this.maxLines,
    this.onChanged,
    this.hintText,
    this.enabled,
    this.initialValue,
    this.charCounter,
    this.maxLength,
    this.autovalidateMode,
  }) : super(key: key);

  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final bool? obscureText;
  final Widget? suffixIcon;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final double? height;
  final int? maxLines;
  final String? hintText;
  final Function(String)? onChanged;
  final bool? enabled;
  final String? initialValue;
  final String? charCounter;
  final int? maxLength;
  final AutovalidateMode? autovalidateMode;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Container(
      height: height ?? size.height * 0.0553,
      decoration: BoxDecoration(
        color: white,
        borderRadius: BorderRadius.circular(7),
      ),
      child: Align(
        alignment: Alignment.center,
        child: TextFormField(
          maxLength: maxLength,
          onChanged: onChanged ?? onChanged,
          controller: controller,
          validator: validator,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 16,
            color: enabled != null
                ? !enabled!
                    ? gray.withOpacity(0.6)
                    : gray
                : gray,
          ),
          obscureText: obscureText ?? false,
          keyboardType: keyboardType,
          autovalidateMode:
              autovalidateMode ?? AutovalidateMode.onUserInteraction,
          decoration: InputDecoration(
            counterStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12,
              color: gray.withOpacity(0.6),
            ),
            counterText: charCounter ?? charCounter,
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(7)),
              borderSide: BorderSide(
                width: 0,
                style: BorderStyle.none,
              ),
            ),
            hintText: hintText ?? 'Escribe aquí',
            hintStyle: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 16,
              color: gray.withOpacity(0.6),
            ),
            filled: true,
            fillColor: white,
            isDense: true,
            isCollapsed: true,
            contentPadding:
                EdgeInsets.symmetric(horizontal: size.width * 0.0417),
            suffixIcon: suffixIcon,
          ),
          initialValue: initialValue,
          textAlignVertical: TextAlignVertical.center,
          inputFormatters: inputFormatters,
          maxLines: maxLines ?? 1,
          enabled: enabled,
        ),
      ),
    );
  }
}
