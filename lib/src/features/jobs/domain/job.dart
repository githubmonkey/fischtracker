import 'package:equatable/equatable.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:flutter/foundation.dart';

typedef JobID = String;

@immutable
class Job extends Equatable {
  const Job({
    required this.id,
    required this.catId,
    required this.name,
    required this.ratePerHour,
    this.lastEntry,
  });

  final JobID id;
  final CatID catId;
  final String name;
  final int ratePerHour;
  final Entry? lastEntry;

  // TODO: shouldn't id be part of the comparison?
  @override
  List<Object> get props => [name, catId, ratePerHour, lastEntry ?? 'N/A'];

  @override
  bool get stringify => true;

  factory Job.fromMap(Map<String, dynamic> data, String id) {
    // optional last entry data
    final lastEntryId = data['lastEntryId'] as String?;
    final startMilliseconds = data['lastEntryStart'] as int?;
    final endMilliseconds = data['lastEntryEnd'] as int?;
    final lastEntryComment = data['lastEntryComment'] as String?;

    final lastEntry = lastEntryId?.isNotEmpty ?? false
        ? Entry(
            id: lastEntryId!,
            jobId: id,
            start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds!),
            end: endMilliseconds == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
            comment: lastEntryComment!)
        : null;

    final name = data['name'] as String;
    final catId = data['catId'] as String;
    final ratePerHour = data['ratePerHour'] as int;

    return Job(
      id: id,
      catId: catId,
      name: name,
      ratePerHour: ratePerHour,
      lastEntry: lastEntry,
    );
  }

  Job copyWith({id, catId, name, ratePerHour, lastEntry}) => Job(
    id: id ?? this.id,
    catId: catId ?? this.catId,
    name: name ?? this.name,
    ratePerHour: ratePerHour ?? this.ratePerHour,
    lastEntry: lastEntry ?? this.lastEntry,
  );

  Map<String, dynamic> toMap() {
    return {
      'catId': catId,
      'name': name,
      'ratePerHour': ratePerHour,
      ... (lastEntry != null) ? {
       'lastEntryId': lastEntry!.id,
       'lastEntryStart': lastEntry!.start,
       if (lastEntry!.end != null) 'lastEntryEnd': lastEntry!.end,
       'lastEntryComment': lastEntry!.comment,
      } : {}
    };
  }

  bool get isOpen => (lastEntry != null && lastEntry!.end == null);
}
