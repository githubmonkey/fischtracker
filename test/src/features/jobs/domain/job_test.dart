import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final date1 = DateTime(2017, 9, 7, 17, 30);
  final date2 = DateTime(2017, 9, 7, 18, 30);

  group('fromMap', () {
    test('job with all properties', () {
      final job = Job.fromMap(const {
        'catId': 'cat-123',
        'name': 'Blogging',
      }, 'abc');
      expect(
          job,
          const Job(
              catId: 'cat-123', name: 'Blogging', id: 'abc'));
    });

    test('missing name', () {
      // * If the 'name' is missing, this error will be emitted:
      // * _CastError:<type 'Null' is not a subtype of type 'String' in type cast>
      // * We can detect it by expecting that the test throws a TypeError
      expect(
          () => Job.fromMap(const {
              }, 'abc'),
          throwsA(isInstanceOf<TypeError>()));
    });

    test('missing catid', () {
      expect(
          () => Job.fromMap(const {
                'name': 'Blogging',
              }, 'abc'),
          throwsA(isInstanceOf<TypeError>()));
    });

    group('fromMap with Entry', () {
      test('job with entry with all properties', () {
        final job = Job.fromMap({
          'catId': 'cat-123',
          'name': 'Blogging',
          'lastEntryId': '345',
          'lastEntryStart': date1.millisecondsSinceEpoch,
          'lastEntryEnd': date2.millisecondsSinceEpoch,
          'lastEntryComment': 'mycomment',
        }, 'abc');
        expect(
          job,
          Job(
            catId: 'cat-123',
            name: 'Blogging',
            id: 'abc',
            lastEntry: Entry(
              id: '345',
              jobId: 'abc',
              start: date1,
              end: date2,
              comment: 'mycomment',
            ),
          ),
        );
      });

      test('job with entry with no end date', () {
        final job = Job.fromMap({
          'catId': 'cat-123',
          'name': 'Blogging',
          'lastEntryId': '345',
          'lastEntryStart': date1.millisecondsSinceEpoch,
          'lastEntryComment': '',
        }, 'abc');
        expect(
          job,
          Job(
            catId: 'cat-123',
            name: 'Blogging',
            id: 'abc',
            lastEntry: Entry(
              id: '345',
              jobId: 'abc',
              start: date1,
              end: null,
              comment: '',
            ),
          ),
        );
      });

      test('bad entryid, remaining values are ignored', () {
        final job = Job.fromMap({
          'catId': 'cat-123',
          'name': 'Blogging',
          'lastEntryId': '',
          'lastEntryStart': date1.millisecondsSinceEpoch,
          'lastEntryEnd': date2.millisecondsSinceEpoch,
          'lastEntryComment': 'mycomment',
        }, 'abc');
        expect(
          job,
          const Job(
            catId: 'cat-123',
            name: 'Blogging',
            id: 'abc',
          ),
        );
      });
    });
  });

  group('toMap', () {
    test('valid name', () {
      const job = Job(
        catId: 'cat-123',
        name: 'Blogging',
        id: 'abc',
      );
      expect(job.toMap(), {
        'catId': 'cat-123',
        'name': 'Blogging',
      });
    });

    group('toMap including Entry', () {
      test('all valid, with end date', () {
        final job = Job(
          catId: 'cat-123',
          name: 'Blogging',
          id: 'abc',
          lastEntry: Entry(
            jobId: 'abc',
            start: date1,
            end: date2,
            comment: 'mycomment',
            id: '345',
          ),
        );
        expect(job.toMap(), {
          'catId': 'cat-123',
          'name': 'Blogging',
          'lastEntryId': '345',
          'lastEntryStart': date1,
          'lastEntryEnd': date2,
          'lastEntryComment': 'mycomment'
        });
      });

      test('all valid, no end date', () {
        final job = Job(
          catId: 'cat-123',
          name: 'Blogging',
          id: 'abc',
          lastEntry: Entry(
            jobId: 'abc',
            start: date1,
            end: null,
            comment: '',
            id: '345',
          ),
        );
        expect(job.toMap(), {
          'catId': 'cat-123',
          'name': 'Blogging',
          'lastEntryId': '345',
          'lastEntryStart': date1,
          'lastEntryComment': ''
        });
      });
    });
  });

  group('equality', () {
    test('different catIds, equality returns false', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blogging', id: 'abc');
      const job2 =
          Job(catId: 'cat-567', name: 'Blogging', id: 'abc');
      expect(job1 == job2, false);
    });
    test('different names, equality returns false', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blogging', id: 'abc');
      const job2 =
          Job(catId: 'cat-123', name: 'Research', id: 'abc');
      expect(job1 == job2, false);
    });
    test('same properties, equality returns true', () {
      const job1 =
          Job(catId: 'cat-123', name: 'Blogging', id: 'abc');
      const job2 =
          Job(catId: 'cat-123', name: 'Blogging', id: 'abc');
      expect(job1 == job2, true);
    });

    test('different start dates in entry, equality returns false', () {
      final job1 = Job(
          catId: 'cat-123',
          name: 'Blogging',
          id: 'abc',
          lastEntry: Entry(
              id: '123', jobId: 'abc', start: date1, end: null, comment: ''));
      final job2 = Job(
          catId: 'cat-123',
          name: 'Blogging',
          id: 'abc',
          lastEntry: Entry(
              id: '123', jobId: 'abc', start: date2, end: null, comment: ''));
      expect(job1 == job2, false);
    });

    test('different end dates in entry, equality returns false', () {
      final job1 = Job(
          catId: 'cat-123',
          name: 'Blogging',
          id: 'abc',
          lastEntry: Entry(
              id: '123', jobId: 'abc', start: date1, end: date2, comment: ''));
      final job2 = Job(
          catId: 'cat-123',
          name: 'Blogging',
          id: 'abc',
          lastEntry: Entry(
              id: '123', jobId: 'abc', start: date1, end: null, comment: ''));
      expect(job1 == job2, false);
    });
  });
}
