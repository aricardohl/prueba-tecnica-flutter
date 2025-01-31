import 'package:flutter/material.dart';

Widget textFieldPassword(context, controller, labelText, hintText) {
    return Center(
        child: TextField(
          maxLength: 100,
          controller: controller,
          obscureText: true,
          decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
              labelText: labelText,
              hintText: hintText),
        ));
  }