import 'package:flutter/material.dart';
import 'package:historial_enfermedades/constants/strings.dart';
import 'package:historial_enfermedades/models/recipe.dart';
import 'package:historial_enfermedades/pages/registro.dart';
import 'package:historial_enfermedades/pages/widgets/image_widget.dart';
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
            preferredSize: Size.fromHeight(50.0),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: TextField(
                decoration: InputDecoration(
                  hintText: AppStrings.searchText,
                  hintStyle: TextStyle(color: Colors.grey[500]),
                  filled: true,
                  fillColor: Colors.grey[300],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30)),
                  prefixIcon: Padding(
                    padding:
                        EdgeInsets.only(left: _deviceWidth * .30, right: 10),
                    child: Icon(
                      Icons.search,
                      color: Colors.grey[600],
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(vertical: 12),
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value.toLowerCase();
                  });
                },
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
            return pacient.contains(_searchQuery) ||
                doctor.contains(_searchQuery) ||
                discomfort.contains(_searchQuery);
          }).toList();
          return ListView.builder(
            itemCount: filteredRecipes.length,
            itemBuilder: (context, index) {
              final recipe = filteredRecipes[index];
              return Column(
                children: [
                  ListTile(
                    subtitle: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)
                      ),
                      elevation: 5,
                      margin: EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            if (recipe.img == AppStrings.pathToDoctorImage)
                              imageAsset(recipe.img, _deviceWidth, _deviceHeight)
                            else
                              imageFile(recipe.img, _deviceWidth, _deviceHeight),
                            SizedBox(
                              width: 10,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    '${AppStrings.pacientLabel}: ${recipe.pacient}'),
                                Text(
                                    overflow: TextOverflow.ellipsis,
                                    '${AppStrings.discomfortLabel}: ${truncateText(recipe.discomfort, 13)}'),
                                Text('${AppStrings.doctorLabel}: ${recipe.doctor}'),
                                Text('${AppStrings.phoneLabel}: ${recipe.phone}'),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
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
    return FloatingActionButton.extended(
      label: Text(AppStrings.addLabel),
      onPressed: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RegistroPage()));
      },
      icon: Icon(Icons.add),
    );
  }
}
