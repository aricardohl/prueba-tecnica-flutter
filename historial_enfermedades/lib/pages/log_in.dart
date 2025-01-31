import 'package:flutter/material.dart';
import 'package:historial_enfermedades/constants/strings.dart';
import 'package:historial_enfermedades/pages/widgets/text_field.dart';
import 'package:historial_enfermedades/pages/widgets/text_field_pass.dart';
import 'package:historial_enfermedades/utils/validators.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<StatefulWidget> createState() {
    return _LoginPageStateClass();
  }
}

class _LoginPageStateClass extends State<Login> {
  late double _deviceHeight;
  late double _deviceWidth;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Por esto es clase Stateful
  String? _newEmail;
  String? _newPassword;

  _LoginPageStateClass();

  @override
  void initState() {
    super.initState();
    emailController.addListener(_handleEmailChange);
    passwordController.addListener(_handlePasswordChange);
  }

  void _handlePasswordChange() {
    _newPassword = passwordController.text;
  }

  void _handleEmailChange() {
    _newEmail = emailController.text;
  }

  Widget buttonIniciarSesion(BuildContext context) {
    return Center(
        child: TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 4, 65, 116))),
            onPressed: () {
              handleButtonLogin(context, _newEmail, _newPassword);
            },
            child: Text(
                style: TextStyle(color: Colors.white), AppStrings.logInText)));
    }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        appBar: AppBar(
          title: const Text(
              style: TextStyle(
                fontSize: 30,
              ),
              AppStrings.logInText),
        ),
        body: SafeArea(
            child: Container(
                height: _deviceHeight,
                width: _deviceWidth,
                padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    textFieldIniciarSesion(context, emailController,
                        AppStrings.labelEmail, AppStrings.hintEmail),
                    SizedBox(height: 20),
                    textFieldPassword(context, passwordController,
                        AppStrings.labelPassword, AppStrings.hintPassword),
                    SizedBox(height: 20),
                    buttonIniciarSesion(context),
                  ],
                ))));
  }
}
