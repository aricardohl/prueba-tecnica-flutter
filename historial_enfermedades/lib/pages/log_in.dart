import 'package:flutter/material.dart';
import 'package:historial_enfermedades/pages/listado.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
      return 'Ingresa un email';
    }
    if (!emailRegex.hasMatch(value)) {
      return 'Ingresa un email valido';
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
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextField(
          maxLength: 100,
          controller: emailController,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
              hintText: 'Ingresa tu email'),
        ));
  }

  Widget textFieldPassword(BuildContext context) {
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextField(
          maxLength: 100,
          controller: passwordController,
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Contraseña',
              hintText: 'Ingresa tu contraseña'),
        ));
  }

  Widget buttonIniciarSesion(BuildContext context) {
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 4, 65, 116))),
            onPressed: () {
              handleButtonLogin();
              // Navigator.push(context,
              //     MaterialPageRoute(builder: (context) => ListadoPage()));
            },
            child:
                Text(style: TextStyle(color: Colors.white), 'Iniciar Sesion')));
  }

  bool handleButtonLogin() {
    if (_newEmail != null && _newPassword != null) {
      if (_newEmail == 'jhon@mail.com' && _newPassword == "77@1\$") {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => ListadoPage()));
      }
      var msg = _validateEmail(_newEmail);
      if (msg != null) {
        toastErrorMessage(context, msg);
      }
      return false;
    }
    return true;
  }

  Future<bool?> toastErrorMessage(BuildContext context, msg) {
    return Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
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
              'Inicio de Sesión'),
        ),
        body: SafeArea(
            child: Container(
          height: _deviceHeight,
          width: _deviceWidth,
          padding: EdgeInsets.symmetric(horizontal: _deviceWidth * 0.05),
          child: Stack(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  SizedBox(height: 20),
                  textFieldEmail(context),
                  SizedBox(height: 20),
                  textFieldPassword(context),
                  SizedBox(height: 20),
                  buttonIniciarSesion(context),
                ],
              )
            ],
          ),
        )));
  }
}
