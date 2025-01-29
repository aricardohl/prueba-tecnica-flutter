import 'package:objectbox/objectbox.dart';

@Entity()
class Recipe {
  int id = 0; // ObjectBox requiere un campo de ID autoincremental

  @Property(type: PropertyType.date) // Indica que es un DateTime
  DateTime date;

  @Index() // Mejora las búsquedas en este campo
  String pacient; // Máx. 150 caracteres

  String doctor; // Máx. 150 caracteres

  @Index()
  String phone; // Máx. 10 caracteres

  String discomfort; // Máx. 1024 caracteres

  String img; // Referencia a la imagen capturada

  Recipe({
    this.id = 0, // El ID se autogenera en ObjectBox
    required this.date,
    required this.pacient,
    required this.doctor,
    required this.phone,
    required this.discomfort,
    required this.img,
  });

  factory Recipe.fromMap(Map recipe) {
    return Recipe(
      date: recipe["date"],
      pacient: recipe["pacient"],
      doctor: recipe["doctor"],
      phone: recipe["phone"],
      discomfort: recipe["discomfort"],
      img: recipe["img"],
    );
  }

 Map toMap() {
    return {
      "id": id,
      "date": date, // Convertimos DateTime a timestamp
      "pacient": pacient,
      "doctor": doctor,
      "phone": phone,
      "discomfort": discomfort,
      "img": img,
    };
  }
}
