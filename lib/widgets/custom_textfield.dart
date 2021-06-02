import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String title;
  final bool validity;
  final String errorMessage;
  final bool obscureText;
  final IconData? iconData;
  final TextInputType? textInputType;
  final int maxLines;

  const CustomTextField({
    required this.controller,
    required this.title,
    required this.validity,
    required this.errorMessage,
    required this.obscureText,
    this.iconData,
    this.textInputType,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: textInputType,
      maxLines: maxLines,
      textInputAction: TextInputAction.next,
      onSubmitted: (v) {
        FocusScope.of(context).requestFocus();
      },
      cursorColor: Theme.of(context).accentColor,
      obscureText: obscureText,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).accentColor.withOpacity(0.2),
        hintText: title,
        hintStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        labelText: title,
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.6)),
        prefixIcon: Icon(iconData, color: Theme.of(context).accentColor),
        enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: Theme.of(context).accentColor.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).accentColor),
          borderRadius: BorderRadius.circular(20.0),
        ),
        errorText: validity ? null : errorMessage,
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.red,
          ),
          borderRadius: BorderRadius.circular(20.0),
        ),
      ),
    );
  }
}
