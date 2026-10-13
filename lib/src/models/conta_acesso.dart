// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

class ContaAcesso {
  String email;
  String password;
  ContaAcesso({
    required this.email,
    required this.password,
  });

  ContaAcesso copyWith({
    String? email,
    String? password,
  }) {
    return ContaAcesso(
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email,
      'password': password,
    };
  }

  factory ContaAcesso.fromMap(Map<String, dynamic> map) {
    return ContaAcesso(
      email: map['email'] as String,
      password: map['password'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory ContaAcesso.fromJson(String source) => ContaAcesso.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'ContaAcesso(email: $email, password: $password)';

  @override
  bool operator ==(covariant ContaAcesso other) {
    if (identical(this, other)) return true;
  
    return 
      other.email == email &&
      other.password == password;
  }

  @override
  int get hashCode => email.hashCode ^ password.hashCode;
}
