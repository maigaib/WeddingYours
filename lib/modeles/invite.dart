// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

// Table invites
class Invite {
  String nom;
  String prenom;
  String email;
  String tel;

  Invite({
    required this.nom,
    required this.prenom,
    required this.email,
    required this.tel,
  });
  

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'nom': nom,
      'prenom': prenom,
      'email': email,
      'telephone': tel,
    };
  }

  factory Invite.fromMap(Map<String, dynamic> map) {
    return Invite(
      nom: map['nom'] as String,
      prenom: map['prenom'] as String,
      email: map['email'] as String,
      tel: map['telephone'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Invite.fromJson(String source) => Invite.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Invite(nom: $nom, prenom: $prenom, email: $email, tel: $tel)';
  }
}
