import 'package:equatable/equatable.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:flutter/foundation.dart';

typedef JobID = String;

@immutable
class Job extends Equatable {
  const Job({
    required this.id,
    required this.name,
    required this.catId,
    required this.catName,
  });

  final JobID id;
  final String name;
  final CatID catId;
  final String catName;

  // TODO: shouldn't id be part of the comparison?
  @override
  List<Object> get props => [name, catId, catName];

  @override
  bool get stringify => true;

  factory Job.fromMap(Map<String, dynamic> data, String id) {
    final name = data['name'] as String;
    final catId = data['catId'] as String;
    final catName = data['catName'] as String;

    return Job(id: id, name: name, catId: catId, catName: catName);
  }

  Job copyWith({id, name, catId, catName}) => Job(
        id: id ?? this.id,
        name: name ?? this.name,
        catId: catId ?? this.catId,
        catName: catName ?? this.catName,
      );

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'catId': catId,
      'catName': catName,
    };
  }

  String get fullName => '$catName / $name';
}
