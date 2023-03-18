import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('fromMap', () {
    test('job with all properties', () {
      final job = Job.fromMap(const {
        'catId': 'cat-123',
        'name': 'Blogging',
        'ratePerHour': 10,
      }, 'abc');
      expect(
          job,
          const Job(
              catId: 'cat-123', name: 'Blogging', ratePerHour: 10, id: 'abc'));
    });

    test('missing name', () {
      // * If the 'name' is missing, this error will be emitted:
      // * _CastError:<type 'Null' is not a subtype of type 'String' in type cast>
      // * We can detect it by expecting that the test throws a TypeError
      expect(
          () => Job.fromMap(const {
                'ratePerHour': 10,
              }, 'abc'),
          throwsA(isInstanceOf<TypeError>()));
    });

    test('missing catid', () {
      expect(
          () => Job.fromMap(const {
                'name': 'Blogging',
                'ratePerHour': 10,
              }, 'abc'),
          throwsA(isInstanceOf<StateError>()));
    });
  });

  group('toMap', () {
    test('valid name, ratePerHour', () {
      const job = Job(
        catId: 'cat-123',
        name: 'Blogging',
        ratePerHour: 10,
        id: 'abc',
      );
      expect(job.toMap(), {
        'catId': 'cat-123',
        'name': 'Blogging',
        'ratePerHour': 10,
      });
    });
  });

  group('equality', () {
    test('different catIds, equality returns false', () {
      const job1 = Job(catId: 'cat-123', name: 'Blogging', ratePerHour: 5, id: 'abc');
      const job2 = Job(catId: 'cat-567', name: 'Blogging', ratePerHour: 5, id: 'abc');
      expect(job1 == job2, false);
    });
    test('different names, equality returns false', () {
      const job1 = Job(catId: 'cat-123', name: 'Blogging', ratePerHour: 5, id: 'abc');
      const job2 = Job(catId: 'cat-123', name: 'Research', ratePerHour: 5, id: 'abc');
      expect(job1 == job2, false);
    });
    test('different rates, equality returns false', () {
      const job1 = Job(catId: 'cat-123', name: 'Blogging', ratePerHour: 10, id: 'abc');
      const job2 = Job(catId: 'cat-123', name: 'Blogging', ratePerHour: 5, id: 'abc');
      expect(job1 == job2, false);
    });
    test('same properties, equality returns true', () {
      const job1 = Job(catId: 'cat-123', name: 'Blogging', ratePerHour: 10, id: 'abc');
      const job2 = Job(catId: 'cat-123', name: 'Blogging', ratePerHour: 10, id: 'abc');
      expect(job1 == job2, true);
    });
  });
}
