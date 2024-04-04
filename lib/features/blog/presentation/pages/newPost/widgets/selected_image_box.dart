import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectedImageBox extends StatefulWidget {
  final File? imageFile;
  final VoidCallback onPressed;
  const SelectedImageBox(
      {super.key, required this.imageFile, required this.onPressed});

  @override
  State<SelectedImageBox> createState() => _SelectedImageBoxState();
}

class _SelectedImageBoxState extends State<SelectedImageBox> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: Image.file(
            widget.imageFile!,
            height: 180,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
        ),
        Align(
          alignment: Alignment.topRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              child: IconButton(
                  onPressed: widget.onPressed,
                  icon: Icon(
                    CupertinoIcons.delete,
                    color: Colors.white,
                  )),
            ),
          ),
        )
      ],
    );
  }
}
