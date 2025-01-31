import 'package:historial_enfermedades/models/recipe.dart';
import '../objectbox.g.dart'; // Archivo generado

class ObjectBox {
  late final Store store;
  late final Box<Recipe> recipeBox;

  static ObjectBox? _instance;

  ObjectBox._create(this.store) {
    recipeBox = store.box<Recipe>();
  }

  static Future<ObjectBox> create() async {
    if (_instance == null) {
      final store = openStore();
      _instance = ObjectBox._create(store);
    }
    return _instance!;
  }
}
