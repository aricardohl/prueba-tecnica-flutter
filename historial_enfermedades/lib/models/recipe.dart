class Recipe {
  DateTime date;
  String pacient; // maxlength: 150
  String doctor; // maxlength: 150
  String phone; // maxlength: 10
  String discomfort; // maxlength: 1024
  String img; // Reference to img captured

  Recipe({
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
    return{
      "date": date,
      "pacient": pacient,
      "doctor": doctor,
      "phone": phone,
      "discomfort": discomfort,
      "img": img,
    };
  }

}