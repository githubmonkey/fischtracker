import 'package:equatable/equatable.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';

// One category and its list of jobs
class CatJobs extends Equatable {
  const CatJobs(this.cat, this.jobs);

final Cat cat;
  final List<Job> jobs;

  @override
  List<Object?> get props => [cat, jobs];

  @override
  bool? get stringify => true;
}
