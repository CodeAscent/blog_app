import 'package:flutter/material.dart';

class NewPostTextField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  const NewPostTextField({
    super.key,
    required this.hint, required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) => value!.trim() == '' ? hint + " is missing!" : null,
      maxLines: null,
      decoration: InputDecoration(
        hintText: hint,
      ),
    );
  }
}
