import 'package:equatable/equatable.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';

class EntryJob extends Equatable {
  const EntryJob(this.entry, this.job);

  final Entry entry;
  final Job job;

  @override
  List<Object?> get props => [entry, job];

  @override
  bool? get stringify => true;
}
