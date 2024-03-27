import 'package:flutter/material.dart';

class RepeatedTextField extends StatelessWidget {
  final String hint;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  final TextInputType? textInputType;
  const RepeatedTextField({
    super.key,
    required this.hint,
    required this.validator,
    required this.controller,
    this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: textInputType,
      decoration: InputDecoration(
          hintText: hint,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))),
    );
  }
}
