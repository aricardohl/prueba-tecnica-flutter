import 'dart:io';

import 'package:flutter/material.dart';
import 'package:historial_enfermedades/models/recipe.dart';
import 'package:historial_enfermedades/pages/listado.dart';
import 'package:historial_enfermedades/pages/takePictureScreen.dart';
import 'package:historial_enfermedades/pages/widgets/errorWidget.dart';
import 'package:historial_enfermedades/services/objectBoxHelper.dart';

class RegistroPage extends StatefulWidget {
  final String? picturePath;
  const RegistroPage({
    Key? key,
    this.picturePath,
  });

  @override
  State<StatefulWidget> createState() {
    return _RegistroPageStateClass();
  }
}

class _RegistroPageStateClass extends State<RegistroPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  final _dateController = TextEditingController();
  final _pacientController = TextEditingController();
  final _doctorController = TextEditingController();
  final _phoneController = TextEditingController();
  final _discomfortController = TextEditingController();

  // Regex to validate Pacient y Doctor
  final regex = RegExp(r'^[a-zA-ZáéíóúÁÉÍÓÚñÑ\s]+$');
  // Regex to validate phone
  final phoneRegex = RegExp(r'^\d{10}$');

  DateTime? _newDate;
  String? _newPacient;
  String? _newDoctor;
  String? _newPhone;
  String? _newError;
  String _newImg = './lib/assets/doctor.png'; // Use for path to image

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2027),
    );
    if (picked != null && picked != _newDate) {
      setState(() {
        _newDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year}';
  }

  String _formatPhone(String phone) {
    if (phone.length != 10) return phone;
    return '(${phone.substring(0, 3)}) ${phone.substring(3, 6)}-${phone.substring(6)}';
  }

  _RegistroPageStateClass();

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_handlePhoneChange);
  }

  void _handlePhoneChange() {
    setState(() {
      _newPhone = _phoneController.text;
    });
  }

  void _checkRegex(value) {
    value = _doctorController.text;
    if (regex.hasMatch(value!)) {
      _newError = null;
    } else {
      _newError = 'Ingresa un nombre valido';
      toastErrorMessage(context, _newError);
    }
  }

  void _checkPhoneRegex(phone) {
    if (phone == null || phone.length != 10) {
      _newError = 'Ingresa un telefono valido';
      toastErrorMessage(context, _newError);
    }
    if (phone != null && !phoneRegex.hasMatch(phone)) {
      setState(() {
        _newError = null;
        _newPhone = _phoneController.text;
        _newPhone = _formatPhone(_newPhone!);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Registro'),
        ),
        body: SingleChildScrollView(
          child: registroView(),
        ));
  }

  Widget registroView() {
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          textFieldDate(context, 'Fecha'),
          SizedBox(height: 20),
          TextField(
            onSubmitted: (value) => _checkRegex(value),
            controller: _pacientController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Paciente',
            ),
            maxLength: 150,
          ),
          SizedBox(height: 20),
          TextField(
            onSubmitted: (value) => _checkRegex(value),
            controller: _doctorController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Doctor',
            ),
            maxLength: 150,
          ),
          SizedBox(height: 20),
          TextField(
            onChanged: (value) => _formatPhone(value),
            keyboardType: TextInputType.phone,
            controller: _phoneController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Telefono',
            ),
            maxLength: 10,
          ),
          SizedBox(height: 20),
          TextField(
            controller: _discomfortController,
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              labelText: 'Malestar, Sintomas',
            ),
            maxLength: 1024,
          ),
          // Image field to take a picture of reipe and save the path reference
          SizedBox(height: 20),
          Column(
            children: [
              TextButton(
                  style: const ButtonStyle(
                      backgroundColor: WidgetStatePropertyAll<Color>(
                          Color.fromARGB(255, 4, 65, 116))),
                  onPressed: () async {
                    _newImg = await Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TakePictureScreen()));
                  }, // Add function to take a picture
                  child: Text(
                      style: const TextStyle(color: Colors.white),
                      'Capturar Receta')),
              SizedBox(height: 20),
              // Add a preview of the image
              if(_newImg == './lib/assets/doctor.png') Image.asset(
                _newImg,
                fit: BoxFit.cover,
                width: _deviceWidth * .45,
                height: _deviceHeight * .15,
              ) else
              Image.file(
                File(_newImg),
                fit: BoxFit.cover,
                width: _deviceWidth * .45,
                height: _deviceHeight * .15,
              )
            ],
          ),
          SizedBox(height: 20),
          registerButton(),
        ],
      ),
    );
  }

  Widget registerButton() {
    return SizedBox(
        child: TextButton(
            style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll<Color>(
                    Color.fromARGB(255, 4, 65, 116))),
            onPressed: () {
              // Validate the fields
              _checkPhoneRegex(_newPhone);
              _checkRegex(_newPacient);
              _checkRegex(_newDoctor);

              // Add the recipe to the database
              var recipe = Recipe(
                pacient: _pacientController.text,
                doctor: _doctorController.text,
                phone: _phoneController.text,
                discomfort: _discomfortController.text,
                date: _newDate!,
                img: _newImg,
              );

              if (_newError == null) {
                ObjectBoxHelper.recipeBox.put(recipe);
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListadoPage()));
              } else {
                toastErrorMessage(context, _newError);
              }
            },
            child: Text(style: TextStyle(color: Colors.white), 'Registrar')));
  }

  Widget textFieldDate(BuildContext context, String label) {
    return SizedBox(
        child: TextField(
      controller: _dateController,
      decoration: InputDecoration(
        border: UnderlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
        labelText: label,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    ));
  }
}
