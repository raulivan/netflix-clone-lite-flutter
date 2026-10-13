// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class PerfilConta {
  String id;
  String name;
  String colorValue;
  PerfilConta({
    required this.id,
    required this.name,
    required this.colorValue,
  });

  PerfilConta copyWith({
    String? id,
    String? name,
    String? colorValue,
  }) {
    return PerfilConta(
      id: id ?? this.id,
      name: name ?? this.name,
      colorValue: colorValue ?? this.colorValue,
    );
  }

  Map<String, String> toMap() {
    return <String, String>{
      'id': id,
      'name': name,
      'colorValue': colorValue,
    };
  }

  factory PerfilConta.fromMap(Map<String, String> map) {
    return PerfilConta(
      id: map['id'] as String,
      name: map['name'] as String,
      colorValue: map['colorValue'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory PerfilConta.fromJson(String source) => PerfilConta.fromMap(json.decode(source) as Map<String, String>);

  @override
  String toString() => 'PerfilConta(id: $id, name: $name, colorValue: $colorValue)';

  @override
  bool operator ==(covariant PerfilConta other) {
    if (identical(this, other)) return true;
  
    return 
      other.id == id &&
      other.name == name &&
      other.colorValue == colorValue;
  }

  @override
  int get hashCode => id.hashCode ^ name.hashCode ^ colorValue.hashCode;
}
