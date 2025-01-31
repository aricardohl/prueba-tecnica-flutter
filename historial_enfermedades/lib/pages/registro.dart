import 'package:flutter/material.dart';
import 'package:historial_enfermedades/constants/strings.dart';
import 'package:historial_enfermedades/models/recipe.dart';
import 'package:historial_enfermedades/pages/_listado.dart';
import 'package:historial_enfermedades/pages/takePictureScreen.dart';
import 'package:historial_enfermedades/pages/widgets/errorWidget.dart';
import 'package:historial_enfermedades/pages/widgets/image_widget.dart';
import 'package:historial_enfermedades/services/object_box_helper.dart';

class RegistroPage extends StatefulWidget {

  const RegistroPage();

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

  String? _newPhone;
  DateTime? _newDate;
  String? _newError;
  String _newImg = AppStrings.pathToDoctorImage;

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
  }

  bool _checkRegex(String value) {
    if(value == '') {
      toastErrorMessage(context, AppStrings.fillAllFields);
      return false;
    }
    if (regex.hasMatch(value)) {
      return true;
    } else {
      _newError = AppStrings.validNameError;
      toastErrorMessage(context, _newError);
      return false;
    }
  }

  bool _checkPhoneRegex(phone) {
    if (phone.isEmpty || phone.length != 10) {
      _newError = AppStrings.validPhoneError;
      toastErrorMessage(context, _newError);
      return false;
    }
    _newPhone = _formatPhone(phone);
    return true;
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(AppStrings.registerLabel),
        ),
        body: SingleChildScrollView(
          child: registroView(),
        ));
  }

  Widget registroView() {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textFieldDate(context, AppStrings.dateLabel),
            SizedBox(height: 20),
            TextField(
              onSubmitted: (value) => _checkRegex(value),
              controller: _pacientController,
              decoration: InputDecoration(
                counterText: '',
                border: UnderlineInputBorder(),
                labelText: AppStrings.pacientLabel,
              ),
              maxLength: 150,
            ),
            SizedBox(height: 20),
            TextField(
              onSubmitted: (value) => _checkRegex(value),
              controller: _doctorController,
              decoration: InputDecoration(
                counterText: '',
                border: UnderlineInputBorder(),
                labelText: AppStrings.doctorLabel,
              ),
              maxLength: 150,
            ),
            SizedBox(height: 20),
            TextField(
              onChanged: (value) => _formatPhone(value),
              keyboardType: TextInputType.phone,
              controller: _phoneController,
              decoration: InputDecoration(
                counterText: '',
                border: UnderlineInputBorder(),
                labelText: AppStrings.phoneLabel,
              ),
              maxLength: 10,
            ),
            SizedBox(height: 20),
            TextField(
              controller: _discomfortController,
              decoration: InputDecoration(
                counterText: '',
                border: UnderlineInputBorder(),
                labelText: AppStrings.discomfortLabel,
              ),
              maxLength: 1024,
            ),
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
                    },
                    child: Text(
                        style: const TextStyle(color: Colors.white),
                        AppStrings.takePhotoRecipe)),
                SizedBox(height: 20),
                if (_newImg == AppStrings.pathToDoctorImage)
                  imageAsset(_newImg, _deviceWidth, _deviceHeight)
                else
                  imageFile(_newImg, _deviceWidth, _deviceHeight)
              ],
            ),
            SizedBox(height: 20),
            registerButton(),
          ],
        ),
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
              onRegisterPressed();
            },
            child: Text(
                style: TextStyle(color: Colors.white), AppStrings.saveLabel)));
  }

  void onRegisterPressed() {
    setState(() {
      _newError = null;
      bool isValid =  _checkRegex(_pacientController.text) &&
                      _checkRegex(_doctorController.text) &&
                      _checkPhoneRegex(_phoneController.text);

      if (!isValid) return;

      var recipe = Recipe(
        pacient: _pacientController.text,
        doctor: _doctorController.text,
        phone: _phoneController.text,
        discomfort: _discomfortController.text,
        date: _newDate!,
        img: _newImg,
      );
      ObjectBoxHelper.recipeBox.put(recipe);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => ListadoPage()));
    });
  }

  Widget textFieldDate(BuildContext context, String label) {
    return SizedBox(
        child: TextField(
      controller: _dateController,
      decoration: InputDecoration(
        counterText: '',
        border: UnderlineInputBorder(),
        suffixIcon: Icon(Icons.calendar_today),
        labelText: label,
      ),
      onTap: () => _selectDate(context),
      readOnly: true,
    ));
  }
}
