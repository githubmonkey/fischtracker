import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

typedef CatID = String;

@immutable
class Cat extends Equatable {
  const Cat({required this.id, required this.name});

  final CatID id;
  final String name;

  @override
  List<Object> get props => [id, name];

  @override
  bool get stringify => true;

  factory Cat.fromMap(Map<String, dynamic> data, String id) {
    final name = data['name'] as String;
    return Cat(id: id, name: name);
  }

  Map<String, dynamic> toMap() {
    return {'name': name};
  }
}
