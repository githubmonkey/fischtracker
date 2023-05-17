import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap', () {
    test('job with all properties', () {
      final job = Job.fromMap(
          const {'name': 'Blog', 'catId': 'cat-123', 'catName': 'Admin'},
          'abc');
      expect(
          job,
          const Job(
              id: 'abc', name: 'Blog', catId: 'cat-123', catName: 'Admin'));
    });

    test('missing name', () {
      // * If the 'name' is missing, this error will be emitted:
      // * _CastError:<type 'Null' is not a subtype of type 'String' in type cast>
      // * We can detect it by expecting that the test throws a TypeError
      expect(() => Job.fromMap(const {}, 'abc'),
          throwsA(isInstanceOf<TypeError>()));
    });

    test('missing catid', () {
      expect(
          () => Job.fromMap(const {'name': 'Blog', 'catName': 'Admin'}, 'abc'),
          throwsA(isInstanceOf<TypeError>()));
    });

    test('missing catName', () {
      expect(
          () => Job.fromMap(const {'name': 'Blog', 'CatId': 'cat-123'}, 'abc'),
          throwsA(isInstanceOf<TypeError>()));
    });
  });

  group('toMap', () {
    test('valid name', () {
      const job = Job(
        id: 'abc',
        name: 'Blog',
        catId: 'cat-123',
        catName: 'Admin',
      );
      expect(job.toMap(), {
        'name': 'Blog',
        'catId': 'cat-123',
        'catName': 'Admin',
      });
    });
  });

  group('equality', () {
    test('different catIds, equality returns false', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blog', catName: 'Admin', id: 'abc');
      const job2 =
          Job(catId: 'cat-567', name: 'Blog', catName: 'Admin', id: 'abc');
      expect(job1 == job2, false);
    });
    test('different names, equality returns false', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blog', catName: 'Admin', id: 'abc');
      const job2 =
          Job(catId: 'cat-123', name: 'Research', catName: 'Admin', id: 'abc');
      expect(job1 == job2, false);
    });
    test('different catBames, equality returns false', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blog', catName: 'Admin', id: 'abc');
      const job2 =
          Job(catId: 'cat-123', name: 'Research', catName: 'Fun', id: 'abc');
      expect(job1 == job2, false);
    });
    test('same properties, equality returns true', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blog', catName: 'Admin', id: 'abc');
      const job2 =
          Job(catId: 'cat-123', name: 'Blog', catName: 'Admin', id: 'abc');
      expect(job1 == job2, true);
    });
  });
}
