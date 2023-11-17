class Utilisateurs {
  final String id;
  final String nom;
  final String prenom;
  final String email;
  final String adresse;
  final String tel;
  final String motDePasse;

  Utilisateurs({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.adresse,
    required this.tel,
    required this.motDePasse,
  });

  factory Utilisateurs.fromMap(Map<String, dynamic> map) {
    return Utilisateurs(
      id: map['id'],
      nom: map['nom'],
      prenom: map['prenom'],
      email: map['email'],
      adresse: map['adresse'],
      tel: map['tel'],
      motDePasse: map['motDePasse'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'adresse': adresse,
      'tel': tel,
      'motDePasse': motDePasse,
    };
  }
}
