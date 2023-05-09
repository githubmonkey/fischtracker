import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:fischtracker/firebase_options.dart';
import 'package:fischtracker/src/app.dart';
import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/cats/data/cats_repository.dart';
import 'package:fischtracker/src/features/entries/data/entries_repository.dart';
import 'package:fischtracker/src/features/jobs/data/jobs_repository.dart';
import 'package:fischtracker/src/features/onboarding/data/onboarding_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mocktail/mocktail.dart';

import '../test/src/mocks.dart';

const String email = 'tester1@foo.bar';
const String password = '123123123';
const String uid = 'mwllcJMmfsRhAiAziiSQuau9ViGi';

void _addJob(cat, name) async {
  final jobsRepository = JobsRepository(FirebaseFirestore.instance);
  await jobsRepository.addJob(
      uid: uid, catId: cat.id, catName: cat.name, name: name);
}

void seedData() async {
  final catsRepository = CatsRepository(FirebaseFirestore.instance);
  await catsRepository.addCat(uid: uid, name: "Teaching");
  await catsRepository.addCat(uid: uid, name: "Research");
  await catsRepository.addCat(uid: uid, name: "Admin");

  final cats = await catsRepository.fetchCats(uid: uid);
  for (var cat in cats) {
    switch (cat.name) {
      case 'Teaching':
        {
          _addJob(cat, 'Lecture');
          _addJob(cat, 'Marking');
          _addJob(cat, 'Mentoring');
        }
        break;
      case 'Research':
        {
          _addJob(cat, 'Thinking');
          _addJob(cat, 'Programming');
          _addJob(cat, 'Writing');
        }
        break;

      case 'Admin':
        {
          _addJob(cat, 'Meetings');
        }
        break;
      default:
        throw Exception("Unkown cat $cat");
    }
  }

  final jobsRepository = JobsRepository(FirebaseFirestore.instance);
  final entriesRepository = EntriesRepository(FirebaseFirestore.instance);

  final jobs = await jobsRepository.fetchJobs(uid: uid);
  for (var job in jobs) {
    switch (job.name) {
      case 'Meetings':
        await entriesRepository.addEntry(
          uid: uid,
          jobId: job.id,
          start: DateTime(2023, 04, 13, 8, 30),
          end: DateTime(2023, 04, 13, 13, 00),
          comment: '',
        );
        await entriesRepository.addEntry(
          uid: uid,
          jobId: job.id,
          start: DateTime(2023, 04, 14, 8, 30),
          end: DateTime(2023, 04, 14, 12, 00),
          comment: '',
        );
        break;
      case 'Lecture':
        await entriesRepository.addEntry(
          uid: uid,
          jobId: job.id,
          start: DateTime(2023, 04, 13, 13, 00),
          end: DateTime(2023, 04, 13, 14, 00),
          comment: '',
        );
        break;
      case 'Thinking':
        await entriesRepository.addEntry(
          uid: uid,
          jobId: job.id,
          start: DateTime(2023, 04, 13, 14, 30),
          end: DateTime(2023, 04, 13, 17, 30),
          comment: '',
        );
        break;
      case 'Writing':
        await entriesRepository.addEntry(
          uid: uid,
          jobId: job.id,
          start: DateTime(2023, 04, 13, 17, 00),
          end: DateTime(2023, 04, 13, 18, 30),
          comment: '',
        );
        break;
      case 'Programming':
        await entriesRepository.addEntry(
          uid: uid,
          jobId: job.id,
          start: DateTime(2023, 04, 14, 13, 00),
          end: null,
          comment: '',
        );
        break;
      default:
        break;
    }
  }
}

void clearData() async {
  var collection =
      FirebaseFirestore.instance.collection(CatsRepository.catsPath(uid));
  var snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }

  collection =
      FirebaseFirestore.instance.collection(JobsRepository.jobsPath(uid));
  snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }

  collection =
      FirebaseFirestore.instance.collection(EntriesRepository.entriesPath(uid));
  snapshots = await collection.get();
  for (var doc in snapshots.docs) {
    await doc.reference.delete();
  }
}

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();

  late MockOnboardingRepository mockOnboardingRepository;
  late MockAuthRepository mockAuthRepository;
  // this is no mock, it just talks to the emulator
  late FirebaseAuth firebaseAuth;

  setUpAll(() async {
    WidgetsApp.debugAllowBannerOverride = false; // Hide the debug banner
    await binding.convertFlutterSurfaceToImage();
    // Connect to the Firebase Auth emulator
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    firebaseAuth = FirebaseAuth.instance;

    await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
    FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  });

  setUp(() async {
    mockOnboardingRepository = MockOnboardingRepository();
    when(() => mockOnboardingRepository.isOnboardingComplete())
        .thenReturn(true);

    // AuthRepository just passes firebaseAuth config which might be set later
    mockAuthRepository = MockAuthRepository();
    // stub methods here, or in the tests
    when(() => mockAuthRepository.authStateChanges())
        .thenAnswer((_) => firebaseAuth.authStateChanges());
    when(() => mockAuthRepository.currentUser)
        .thenAnswer((_) => firebaseAuth.currentUser);
  });

  group('unauthenticated', () {
    setUpAll(() async {
      await firebaseAuth.signOut();
    });

    testWidgets('Authentication Screen', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          onboardingRepositoryProvider
              .overrideWith((ref) => mockOnboardingRepository),
        ],
        child: const MyApp(),
      ));
      await tester.pumpAndSettle();
      // auth_screen
      await binding.takeScreenshot('1_en-US');
      expect(find.text('Sign in with Google'), findsOneWidget);
    });
  });

  group('authenticated', () {
    setUpAll(() async {
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      clearData();
    });

    testWidgets('Timer Screen without data', (WidgetTester tester) async {
      await tester.pumpWidget(ProviderScope(
        overrides: [
          onboardingRepositoryProvider
              .overrideWith((ref) => mockOnboardingRepository),
          authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
          firebaseAuthProvider.overrideWith((ref) => firebaseAuth),
        ],
        child: const MyApp(),
      ));
      await tester.pumpAndSettle();
      // timer_screen_empty
      await binding.takeScreenshot('2_en-US');
      expect(find.text('Build a topology to get started.'), findsOneWidget);
    });

    group('using emulator data', () {
      setUpAll(() async {
        seedData();
      });

      testWidgets('Timer Screen with emulator data',
          (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(
          overrides: [
            onboardingRepositoryProvider
                .overrideWith((ref) => mockOnboardingRepository),
            authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
            firebaseAuthProvider.overrideWith((ref) => firebaseAuth),
          ],
          child: const MyApp(),
        ));
        await tester.pumpAndSettle();
        // timer_screen
        await binding.takeScreenshot('4_en-US');
        expect(find.text('Admin'), findsOneWidget);
      });

      testWidgets('Topology Screen with emulator data',
          (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(
          overrides: [
            onboardingRepositoryProvider
                .overrideWith((ref) => mockOnboardingRepository),
            authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
            firebaseAuthProvider.overrideWith((ref) => firebaseAuth),
          ],
          child: const MyApp(),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("Topology"), warnIfMissed: true);
        await tester.pumpAndSettle();
        // topo_screen
        await binding.takeScreenshot('3_en-US');
        expect(find.text('Admin'), findsOneWidget);
      });

      testWidgets('Entry Screen with emulator data',
          (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(
          overrides: [
            onboardingRepositoryProvider
                .overrideWith((ref) => mockOnboardingRepository),
            authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
            firebaseAuthProvider.overrideWith((ref) => firebaseAuth),
          ],
          child: const MyApp(),
        ));
        await tester.pumpAndSettle();
        final Finder topoButton = find.text("Entries");
        await tester.tap(topoButton, warnIfMissed: true);
        await tester.pumpAndSettle();
        // entry_screen
        await binding.takeScreenshot('5_en-US');
        expect(find.text('Research / Writing'), findsOneWidget);
      });

      testWidgets('Edit Existing Entry', (WidgetTester tester) async {
        await tester.pumpWidget(ProviderScope(
          overrides: [
            onboardingRepositoryProvider
                .overrideWith((ref) => mockOnboardingRepository),
            authRepositoryProvider.overrideWith((ref) => mockAuthRepository),
            firebaseAuthProvider.overrideWith((ref) => firebaseAuth),
          ],
          child: const MyApp(),
        ));
        await tester.pumpAndSettle();
        await tester.tap(find.text("Entries"), warnIfMissed: true);
        await tester.pumpAndSettle();
        await tester.tap(find.text("Research / Programming"), warnIfMissed: true);
        await tester.pumpAndSettle();
        // entry_edit_screen
        await binding.takeScreenshot('6_en-US');
        expect(find.text('Still Ongoing...'), findsOneWidget);
      });
    });
  });
}
