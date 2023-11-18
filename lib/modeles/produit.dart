class Produit {
  int produitId;
  String nom;
  String image;
  double prix;
  int prestataireId;

  Produit({
    required this.produitId,
    required this.nom,
    required this.image,
    required this.prix,
    required this.prestataireId,
  });

  factory Produit.fromMap(Map<String, dynamic> map) {
    return Produit(
      produitId: map['produitId'],
      nom: map['nom'],
      image: map['image'],
      prix: map['prix'],
      prestataireId: map['prestataireId'],
    );
  }
}