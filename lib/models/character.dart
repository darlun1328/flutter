class Character {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;

  Character(
      {required this.id,
      required this.name,
      required this.status,
      required this.species,
      required this.gender,
      required this.image});

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['_id'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      species: json['species'] as String,
      gender: json['gender'] as String,
      image: json['image'] as String,
    );
  }
}
