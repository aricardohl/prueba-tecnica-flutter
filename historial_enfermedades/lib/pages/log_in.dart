import 'package:flutter/material.dart';
import 'package:historial_enfermedades/constants/strings.dart';
import 'package:historial_enfermedades/pages/_listado.dart';
import 'package:historial_enfermedades/pages/widgets/errorWidget.dart';

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

  final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  //Por esto es clase Stateful
  String? _newEmail;
  String? _newPassword;
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

  Widget textFieldEmail(BuildContext context) {
    return Center(
        child: TextField(
          maxLength: 100,
          controller: emailController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppStrings.labelEmail,
              hintText: AppStrings.hintEmail),
        ));
  }

  Widget textFieldPassword(BuildContext context) {
    return Center(
        child: TextField(
          maxLength: 100,
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: AppStrings.labelPassword,
              hintText: AppStrings.hintPassword),
        ));
  }

  Widget buttonIniciarSesion(BuildContext context) {
    return Center(
        child: TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 4, 65, 116))),
            onPressed: () {
              handleButtonLogin();
            },
            child:
                Text(style: TextStyle(color: Colors.white), AppStrings.logInText)));
  }

  bool handleButtonLogin() {
    if(_newEmail == null || _newEmail!.isEmpty || _newPassword == null || _newPassword!.isEmpty) {
      toastErrorMessage(context, AppStrings.sendEmailPasswordError);
      return false;
    }
    final emailErrorMsg = _validateEmail(_newEmail);
    if(emailErrorMsg != null) {
      toastErrorMessage(context, emailErrorMsg);
      return false;
    }
    if (_newEmail == 'jhon@mail.com' && _newPassword == "77@1\$") {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => ListadoPage()));
    } else {
      toastErrorMessage(context, AppStrings.mailPasswordError);
    }
    return false;
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
                  textFieldEmail(context),
                  SizedBox(height: 20),
                  textFieldPassword(context),
                  SizedBox(height: 20),
                  buttonIniciarSesion(context),
                ],
              )
        )
      )
    );
  }
}
