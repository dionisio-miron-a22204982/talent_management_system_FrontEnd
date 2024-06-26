import 'package:tfc_versaofinal/models/normal_user.dart';

class Competencias {
  final int id;
  final String name;
  final String type;
  final NormalUser? author;


  Competencias({
    required this.id,
    required this.name,
    required this.type,
    required this.author
  });

  factory Competencias.fromMap(Map<String, dynamic> map) {
    return Competencias(
      id: map['id'],  // Ensuring id is a String
      name: map['nome'] ?? '',
      type: map['type'] ?? '',
      author: map['author'] != null ? NormalUser.fromMap(map['author']) : null,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nome': name,
      'type': type,
      'author': author?.toMap(),
    };
  }
}
