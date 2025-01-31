import 'package:flutter/material.dart';
import 'package:historial_enfermedades/constants/strings.dart';
import 'package:historial_enfermedades/pages/_listado.dart';
import 'package:historial_enfermedades/pages/widgets/errorWidget.dart';

final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');

String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return AppStrings.emailError;
    }
    if (!emailRegex.hasMatch(value)) {
      return AppStrings.validEmailError;
    } else {
      return null;
    }
  }

bool handleButtonLogin(context, String? email, String? password) {
    if(email == null || email.isEmpty || password == null || password.isEmpty) {
      toastErrorMessage(context, AppStrings.sendEmailPasswordError);
      return false;
    }
    final emailErrorMsg = _validateEmail(email);
    if(emailErrorMsg != null) {
      toastErrorMessage(context, emailErrorMsg);
      return false;
    }
    if (email == 'jhon@mail.com' && password == "77@1\$") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ListadoPage()));
    } else {
      toastErrorMessage(context, AppStrings.mailPasswordError);
    }
    return false;
  }