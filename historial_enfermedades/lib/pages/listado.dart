import 'package:flutter/material.dart';
import 'package:historial_enfermedades/models/recipe.dart';
import 'package:historial_enfermedades/pages/registro.dart';
import 'package:historial_enfermedades/tools/objectBoxHelper.dart';

class ListadoPage extends StatefulWidget {
  ListadoPage();

  @override
  State<StatefulWidget> createState() {
    return _ListadoPageStateClass();
  }
}

class _ListadoPageStateClass extends State<ListadoPage> {
  late double _deviceHeight;
  late double _deviceWidth;

  _ListadoPageStateClass();

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
        title: const Text('Listado'),
      ),
      body: ListadoView(),
      floatingActionButton: registerButton(),
    );
  }

  Widget ListadoView() {
    return FutureBuilder(
      future: getRecipes(),
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.hasData) {
          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final recipe = snapshot.data![index];
              return ListTile(
                subtitle: Row(
                  children: [
                    Image.asset(
                      './lib/assets/doctor.png',
                      width: _deviceWidth * 0.45,
                      height: _deviceHeight * 0.1,
                    ),
                    Column(
                      children: [
                        Text('Paciente: ${recipe.pacient}'),
                        Text('Malestar: ${recipe.discomfort}'),
                        Text('Doctor: ${recipe.doctor}'),
                        Text('Tel: ${recipe.phone}'),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        } else {
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Future<List<Recipe>> getRecipes() async {
    return Future.delayed(
        Duration(milliseconds: 500), () => ObjectBoxHelper.recipeBox.getAll());
  }

  Widget registerButton() {
    return FloatingActionButton(
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegistroPage()));
      },
      child: Icon(Icons.add),
    );
  }
}
