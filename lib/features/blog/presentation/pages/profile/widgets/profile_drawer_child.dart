import 'package:flutter/material.dart';

class ProfileDrawerChild extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final IconData icon;
  const ProfileDrawerChild({
    super.key,
    required this.label,
    required this.onPressed,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(label),
            SizedBox(width: 5),
            Icon(icon),
          ],
        ),
      ),
    );
  }
}
