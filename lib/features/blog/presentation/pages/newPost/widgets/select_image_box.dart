import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectImageBox extends StatelessWidget {
  const SelectImageBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return DottedBorder(
        color: Colors.white,
        dashPattern: [10, 4],
        radius: Radius.circular(10),
        borderType: BorderType.RRect,
        strokeCap: StrokeCap.round,
        child: Container(
          width: double.infinity,
          height: 180,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(CupertinoIcons.folder),
              SizedBox(height: 20),
              Text("Select your image"),
            ],
          ),
        ));
  }
}
