// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:blog_app/core/common/utils/app_colors.dart';

class CustomRoundedChip extends StatelessWidget {
  final String label;
  const CustomRoundedChip({
    Key? key,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Chip(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
        backgroundColor: primaryColor(),
        label: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.w600),
        ));
  }
}
