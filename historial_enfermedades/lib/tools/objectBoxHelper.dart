import 'package:historial_enfermedades/models/recipe.dart';
import '../objectbox.g.dart'; // Importa el archivo generado

class ObjectBoxHelper {
  static late final Store _store;
  static late final Box<Recipe> _recipeBox;
  static bool _initialized = false;

  // Método para inicializar ObjectBox
  static Future<void> init(String directory) async {
    if (_initialized) return; // Si ya está inicializado, no lo vuelve a hacer

    _store = openStore(directory: directory); // Abre la base de datos
    _recipeBox = _store.box<Recipe>(); // Obtiene el Box de Recipe

    _initialized = true;
  }

  // Método para obtener el Box de Recipe
  static Box<Recipe> get recipeBox {
    if (!_initialized) {
      throw Exception("ObjectBox no ha sido inicializado. Llama a init() primero.");
    }
    return _recipeBox;
  }
}
