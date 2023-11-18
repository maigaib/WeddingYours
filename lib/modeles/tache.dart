// Table taches
class Tache {
  int tacheId;
  String nom;
  String description;
  String status;
  int mariageId;

  Tache({
    required this.tacheId,
    required this.nom,
    required this.description,
    required this.status,
    required this.mariageId,
  });

  factory Tache.fromMap(Map<String, dynamic> map) {
    return Tache(
      tacheId: map['tacheId'],
      nom: map['nom'],
      description: map['description'],
      status: map['status'],
      mariageId: map['mariageId'],
    );
  }
}