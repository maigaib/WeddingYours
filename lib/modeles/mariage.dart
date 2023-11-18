
class Mariage {
  int mariageId;
  String monsieur;
  String madame;
  String lieu;
  DateTime date;
  String photo;
  int utilisateursId;

  Mariage({
    required this.mariageId,
    required this.monsieur,
    required this.madame,
    required this.lieu,
    required this.date,
    required this.photo,
    required this.utilisateursId,
  });
 // Ajoutez cette méthode pour convertir l'objet Mariage en Map
  Map<String, dynamic> toMap() {
    return {
      'mariageId': mariageId,
      'monsieur': monsieur,
      'madame': madame,
      'lieu': lieu,
      'date': date,
      'photo': photo,
      'utilisateursId': utilisateursId,
    };
  }
  factory Mariage.fromMap(Map<String, dynamic> map) {
    return Mariage(
      mariageId: map['mariageId'],
      monsieur: map['monsieur'],
      madame: map['madame'],
      lieu: map['lieu'],
      date: map['date'],
      photo: map['photo'],
      utilisateursId: map['utilisateursId'],
    );
  }
}