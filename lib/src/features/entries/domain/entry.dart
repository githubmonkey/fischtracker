import 'package:equatable/equatable.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';

typedef EntryID = String;

class Entry extends Equatable {
  const Entry({
    required this.id,
    required this.jobId,
    required this.start,
    required this.end,
    required this.comment,
  });

  final EntryID id;
  final JobID jobId;
  final DateTime start;
  final DateTime? end;
  final String comment;

  @override
  List<Object> get props => [id, jobId, start, end ?? 0, comment];

  @override
  bool get stringify => true;

  Duration get duration => (end ?? DateTime.now()).difference(start);

  factory Entry.fromMap(Map<dynamic, dynamic> value, EntryID id) {
    final startMilliseconds = value['start'] as int;
    final endMilliseconds = value['end'] as int?;
    return Entry(
      id: id,
      jobId: value['jobId'] as String,
      start: DateTime.fromMillisecondsSinceEpoch(startMilliseconds),
      end: endMilliseconds == null
          ? null
          : DateTime.fromMillisecondsSinceEpoch(endMilliseconds),
      comment: value['comment'] as String? ?? '',
    );
  }

  Entry copyWith(
          {EntryID? id,
          JobID? jobId,
          DateTime? start,
          DateTime? end,
          String? comment}) =>
      Entry(
        id: id ?? this.id,
        jobId: jobId ?? this.jobId,
        start: start ?? this.start,
        end: end ?? this.end,
        comment: comment ?? this.comment,
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'jobId': jobId,
      'start': start.millisecondsSinceEpoch,
      'end': end?.millisecondsSinceEpoch,
      'comment': comment,
    };
  }
}
