import 'package:flutter/material.dart';
import 'package:historial_enfermedades/pages/log_in.dart';
import 'package:historial_enfermedades/services/objectBoxHelper.dart';
import 'package:path_provider/path_provider.dart'; // Importa path_provider


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

   final directory = await getApplicationDocumentsDirectory();
  WidgetsFlutterBinding.ensureInitialized();
  await ObjectBoxHelper.init(directory.path);
  // ObjectBoxHelper.recipeBox.remove(11);  NO LO QUITE
  ObjectBoxHelper.recipeBox.remove(12);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Historial de Enfermedades Familiares',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 4, 73, 130)),
        useMaterial3: true,
      ),
      home: Login(),
    );
  }
}