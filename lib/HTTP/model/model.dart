// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';





class User {
  final String name;
  final int amt;
  final int userId;

  User({
    required this.name,
    required this.amt,
    required this.userId,
  });





  User copyWith({
    String? name,
    int? amt,
    int? userId,
  }) {
    return User(
      name: name ?? this.name,
      amt: amt ?? this.amt,
      userId: userId ?? this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'amount': amt,
      'id': userId,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      name: map['name'] as String,
      amt: map['amount'] as int,
      userId: map['id'] as int,
    );
  }

  String toJson() => json.encode(toMap());

  factory User.fromJson(String source) => User.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'name: $name, amt: $amt, userId: $userId';




}
