//import 'package:auth_widget_builder/auth_widget_builder.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:fischtracker/firebase_options.dart';
import 'package:fischtracker/src/app.dart';
import 'package:fischtracker/src/features/onboarding/data/onboarding_repository.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore:depend_on_referenced_packages
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:logging/logging.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } catch (e) {
    debugPrint("Firebase couldn't be initialized: $e");
  }

  // if (kDebugMode) {
  //   FirebaseFirestore.instance.useFirestoreEmulator('localhost', 8080);
  //   await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  // }

  if (kReleaseMode) {
    // Don't log anything below warnings in production.
    Logger.root.level = Level.WARNING;
  } else if (kDebugMode) {
    // Log more when in debug mode.
    Logger.root.level = Level.INFO;
  }
  FirebaseCrashlytics? crashlytics = FirebaseCrashlytics.instance;

  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}';

    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
    debugPrint(message);
    // Add the message to the rotating Crashlytics log.
    crashlytics.log(message);

    if (record.level >= Level.SEVERE) {
      crashlytics.recordError(message, filterStackTrace(StackTrace.current),
          fatal: true);
    }
  });

  // turn off the # in the URLs on the web
  usePathUrlStrategy();
  final sharedPreferences = await SharedPreferences.getInstance();

  registerErrorHandlers();
  // * Entry point of the app

  final container = ProviderContainer(
    overrides: [
      onboardingRepositoryProvider.overrideWithValue(
        OnboardingRepository(sharedPreferences),
      ),
    ],
  );
  runApp(UncontrolledProviderScope(
    container: container,
    child: const MyApp(),
  ));
}

void registerErrorHandlers() {
  // * Show some error UI if any uncaught exception happens
  FlutterError.onError = (FlutterErrorDetails details) {
    FirebaseCrashlytics.instance.recordFlutterFatalError(details);
    //FlutterError.presentError(details);
    debugPrint(details.toString());
  };
  // * Handle errors from the underlying platform/OS
  PlatformDispatcher.instance.onError = (Object error, StackTrace stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    debugPrint(error.toString());
    return true;
  };
  // * Show some error UI when any widget in the app fails to build
  ErrorWidget.builder = (FlutterErrorDetails details) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: Text('An error occurred'.hardcoded),
      ),
      body: Center(child: Text(details.toString())),
    );
  };

  Logger.root.onRecord.listen((record) {
    final message = '${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}';

    debugPrint('${record.level.name}: ${record.time}: '
        '${record.loggerName}: '
        '${record.message}');
    debugPrint(message);
    // Add the message to the rotating Crashlytics log.
    FirebaseCrashlytics.instance.log(message);

    if (record.level >= Level.SEVERE) {
      FirebaseCrashlytics.instance.recordError(
          message, filterStackTrace(StackTrace.current),
          fatal: true);
    }
  });
}

/// Takes a [stackTrace] and creates a new one, but without the lines that
/// have to do with this file and logging. This way, Crashlytics won't group
/// all messages that come from this file into one big heap just because
/// the head of the StackTrace is identical.
///
/// See this:
/// https://stackoverflow.com/questions/47654410/how-to-effectively-group-non-fatal-exceptions-in-crashlytics-fabrics.
@visibleForTesting
StackTrace filterStackTrace(StackTrace stackTrace) {
  try {
    final lines = stackTrace.toString().split('\n');
    final buf = StringBuffer();
    for (final line in lines) {
      if (line.contains('_BroadcastStreamController.java') ||
          line.contains('logger.dart')) {
        continue;
      }
      buf.writeln(line);
    }
    return StackTrace.fromString(buf.toString());
  } catch (e) {
    debugPrint('Problem while filtering stack trace: $e');
  }

  // If there was an error while filtering,
  // return the original, unfiltered stack track.
  return stackTrace;
}
