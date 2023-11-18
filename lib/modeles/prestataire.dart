// Table prestataires
class Prestataire {
  int prestataireId;
  String nom;
  String email;
  String description;
  String tel;
  double note;
  int typesId;

  Prestataire({
    required this.prestataireId,
    required this.nom,
    required this.email,
    required this.description,
    required this.tel,
    required this.note,
    required this.typesId,
  });

  factory Prestataire.fromMap(Map<String, dynamic> map) {
    return Prestataire(
      prestataireId: map['prestataireId'],
      nom: map['nom'],
      email: map['email'],
      description: map['description'],
      tel: map['tel'],
      note: map['note'],
      typesId: map['typesId'],
    );
  }
}
