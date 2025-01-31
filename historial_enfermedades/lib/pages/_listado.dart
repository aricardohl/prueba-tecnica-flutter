import 'dart:io';
import 'package:flutter/material.dart';
import 'package:historial_enfermedades/constants/strings.dart';
import 'package:historial_enfermedades/models/recipe.dart';
import 'package:historial_enfermedades/pages/registro.dart';
import 'package:historial_enfermedades/services/object_box_helper.dart';

class ListadoPage extends StatefulWidget {
  const ListadoPage();

  @override
  State<StatefulWidget> createState() {
    return _ListadoPageStateClass();
  }
}

class _ListadoPageStateClass extends State<ListadoPage> {
  late double _deviceHeight;
  late double _deviceWidth;
  late Future<List<Recipe>> _recipes;

  String _searchQuery = '';

  _ListadoPageStateClass();

  @override
  void initState() {
    super.initState();
    _recipes = getRecipes();
  }

  @override
  Widget build(BuildContext context) {
    _deviceHeight = MediaQuery.of(context).size.height;
    _deviceWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(AppStrings.listadoText),
        bottom: PreferredSize(
            preferredSize: Size.fromHeight(60.0),
            child: Padding(
              padding: EdgeInsets.all(8.0),
              child: TextField(
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
                decoration: InputDecoration(
                  hintText: AppStrings.searchText,
                ),
              
              ),
              
            )),
      ),
      body: listadoView(),
      floatingActionButton: registerButton(),
    );
  }

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    } else {
      return '${text.substring(0, maxLength)}...';
    }
  }

  Widget listadoView() {
    return FutureBuilder(
      future: _recipes,
      builder: (context, AsyncSnapshot<List<Recipe>> snapshot) {
        if (snapshot.hasData) {
          final filteredRecipes = snapshot.data!.where((recipe) {
            final pacient = recipe.pacient.toLowerCase();
            final doctor = recipe.doctor.toLowerCase();
            final discomfort = recipe.discomfort.toLowerCase();
            return pacient.contains(_searchQuery) || doctor.contains(_searchQuery) || discomfort.contains(_searchQuery);
          }).toList();
          return ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = filteredRecipes[index];
              return ListTile(
                subtitle: Row(
                  children: [
                    if (recipe.img == AppStrings.pathToDoctorImage)
                      Flexible(
                        child: Image.asset(
                          recipe.img,
                          width: _deviceWidth * 0.35,
                          height: _deviceHeight * .15,
                          fit: BoxFit.cover,
                        ),
                      )
                    else
                      Flexible(
                        child: Image.file(
                          File(recipe.img),
                          width: _deviceWidth * .35,
                          height: _deviceHeight * .15,
                          fit: BoxFit.cover,
                        ),
                      ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('${AppStrings.pacientLabel}: ${recipe.pacient}'),
                        Text(
                            overflow: TextOverflow.ellipsis,
                            '${AppStrings.discomfortLabel}: ${truncateText(recipe.discomfort, 13)}'),
                        Text('${AppStrings.doctorLabel}: ${recipe.doctor}'),
                        Text('${AppStrings.phoneLabel}: ${recipe.phone}'),
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
