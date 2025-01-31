
import 'package:flutter/material.dart';

Widget textFieldIniciarSesion(context, controller, labelText, hintText) {
    return Center(
        child: TextField(
          maxLength: 100,
          controller: controller,
          decoration: InputDecoration(
              counterText: '',
              border: OutlineInputBorder(),
              labelText: labelText,
              hintText: hintText),
        ));
  }