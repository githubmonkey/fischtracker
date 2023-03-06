import 'package:equatable/equatable.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:flutter/foundation.dart';

typedef JobID = String;

@immutable
class Job extends Equatable {
  const Job({
    required this.id,
    required this.catId,
    required this.name,
    required this.ratePerHour,
  });

  final JobID id;
  final CatID catId;
  final String name;
  final int ratePerHour;

  // TODO: shouldn't id be part of the comparison?
  @override
  List<Object> get props => [name, catId, ratePerHour];

  @override
  bool get stringify => true;

  factory Job.fromMap(Map<String, dynamic> data, String id) {
    final name = data['name'] as String;
    final catId = data['catId'] as String;
    final ratePerHour = data['ratePerHour'] as int;
    return Job(
      id: id,
      catId: catId,
      name: name,
      ratePerHour: ratePerHour,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'name': name,
      'ratePerHour': ratePerHour,
    };
  }
}
