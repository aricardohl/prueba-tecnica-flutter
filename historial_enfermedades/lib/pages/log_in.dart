import 'package:flutter/material.dart';
import 'package:historial_enfermedades/pages/Listado.dart';

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


  //Por esto es clase Stateful
  String? _newEmail;
  String? _newPassword;

  _LoginPageStateClass();

  @override
  void initState() {
    super.initState();
  }

  Widget textFieldEmail(BuildContext context) {
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextField(
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: 'Email'),
        ));
  }

  Widget textFieldPassword(BuildContext context) {
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextField(
          obscureText: true,
          decoration: InputDecoration(
              border: OutlineInputBorder(), labelText: 'Contraseña'),
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
              // Use function handleButtonLogin
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) =>  Listado()));
            },
            child:
                Text(style: TextStyle(color: Colors.white), 'Iniciar Sesion')));
  }

  bool handleButtonLogin() {
    // Handle login asking database for email and password
    return true;
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
