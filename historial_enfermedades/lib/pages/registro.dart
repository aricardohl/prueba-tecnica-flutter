import 'package:flutter/material.dart';

class RegistroPage extends StatefulWidget {
  RegistroPage();

  @override
  State<StatefulWidget> createState() {
    return _RegistroPageStateClass();
  }
}

class _RegistroPageStateClass extends State<RegistroPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  String? _newDate;
  String? _newPacient;
  String? _newDoctor;
  String? _newPhone;
  String? _newDiscomfort;
  String? _newImg; // Use for path to image

  

  _RegistroPageStateClass();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: RegistroView(),
    );
  }


  Widget RegistroView() {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textField(context, 'Fecha'),
          SizedBox(height: 20),
          textField(context, 'Paciente'),
          SizedBox(height: 20),
          textField(context, 'Doctor'),
          SizedBox(height: 20),
          textField(context, 'Teléfono'),
          // Image field to take a picture of reipe and save the path reference
          registerButton(),
        ],
      ),
    );
  }

  Widget textField(BuildContext context, String label) {
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextField(
          decoration:
              InputDecoration(border: OutlineInputBorder(), labelText: label),
        ));
  }

  Widget registerButton() {
    return SizedBox(
        width: _deviceWidth * 0.75,
        child: TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 4, 65, 116))),
            onPressed: () {
              // Use function handleButtonLogin
              // Navigator.push(
              //     context, MaterialPageRoute(builder: (context) => ListadoPage()));
            },
            child:
                Text(style: TextStyle(color: Colors.white), 'Registrar')));
  }	

}