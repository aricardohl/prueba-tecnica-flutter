import 'package:flutter/material.dart';
import 'package:historial_enfermedades/pages/log_in.dart';

void main() {
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