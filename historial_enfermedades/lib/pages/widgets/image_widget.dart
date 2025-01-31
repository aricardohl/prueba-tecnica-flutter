import 'dart:io';

import 'package:flutter/material.dart';

Widget imageAsset(img, width, height) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(10),
    child: Image.asset(
      img,
      fit: BoxFit.cover,
      width: width * .45,
      height: height * .15,
    ),
  );
}
Widget imageFile(img, width, height) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      image: DecorationImage(
        image: FileImage(
          File(img),
        ),
        fit: BoxFit.cover,
      ),
    ),
    width: width * .35,
    height: height * .15,
  );
}