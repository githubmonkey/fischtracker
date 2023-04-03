import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/presentation/custom_profile_screen.dart';
import 'package:fischtracker/src/features/authentication/presentation/custom_sign_in_screen.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/cat_jobs_screen/cat_jobs_screen.dart';
import 'package:fischtracker/src/features/cats/presentation/edit_cat_screen/edit_cat_screen.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/entries/presentation/entries_screen/entries_screen.dart';
import 'package:fischtracker/src/features/entries/presentation/entry_screen/entry_screen.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/jobs/presentation/edit_job_screen/edit_job_screen.dart';
import 'package:fischtracker/src/features/jobs/presentation/job_entries_screen/job_entries_screen.dart';
import 'package:fischtracker/src/features/onboarding/data/onboarding_repository.dart';
import 'package:fischtracker/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fischtracker/src/features/timers/presentation/timers_screen/timers_screen.dart';
import 'package:fischtracker/src/features/topology/presentation/topo_screen.dart';
import 'package:fischtracker/src/routing/go_router_refresh_stream.dart';
import 'package:fischtracker/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onboarding,
  signIn,
  timers,
  topo,
  cats,
  cat,
  addCat,
  editCat,
  jobs,
  job,
  addJob,
  editJob,
  editEntryViaJob,
  entries,
  addEntry,
  editEntry,
  profile,
}

@riverpod
// ignore: unsupported_provider_value
GoRouter goRouter(GoRouterRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  final onboardingRepository = ref.watch(onboardingRepositoryProvider);
  return GoRouter(
    initialLocation: '/signIn',
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      final didCompleteOnboarding = onboardingRepository.isOnboardingComplete();
      if (!didCompleteOnboarding) {
        // Always check state.subloc before returning a non-null route
        // https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart#L78
        if (state.subloc != '/onboarding') {
          return '/onboarding';
        }
      }
      final isLoggedIn = authRepository.currentUser != null;
      if (isLoggedIn) {
        if (state.subloc.startsWith('/signIn')) {
          return '/timers';
        }
      } else {
        if (state.subloc.startsWith('/timers') ||
            state.subloc.startsWith('/topo') ||
            state.subloc.startsWith('/cats') ||
            state.subloc.startsWith('/jobs') ||
            state.subloc.startsWith('/entries') ||
            state.subloc.startsWith('/account')) {
          return '/signIn';
        }
      }
      return null;
    },
    refreshListenable: GoRouterRefreshStream(authRepository.authStateChanges()),
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoute.onboarding.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const OnboardingScreen(),
        ),
      ),
      GoRoute(
        path: '/signIn',
        name: AppRoute.signIn.name,
        pageBuilder: (context, state) => NoTransitionPage(
          key: state.pageKey,
          child: const CustomSignInScreen(),
        ),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/timers',
            name: AppRoute.timers.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TimersScreen(),
            ),
          ),
          GoRoute(
            path: '/topology',
            name: AppRoute.topo.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const TopoScreen(),
            ),
            routes: [
              GoRoute(
                path: 'cat/add',
                name: AppRoute.addCat.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const EditCatScreen(),
                  );
                },
              ),
              GoRoute(
                path: 'cat/:cid',
                name: AppRoute.cat.name,
                pageBuilder: (context, state) {
                  final cid = state.params['cid']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: CatJobsScreen(catId: cid),
                  );
                },
              ),
              GoRoute(
                path: 'cat/:cid/edit',
                name: AppRoute.editCat.name,
                pageBuilder: (context, state) {
                  final catId = state.params['cid'];
                  final cat = state.extra as Cat?;
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: EditCatScreen(catId: catId, cat: cat),
                  );
                },
              ),
              GoRoute(
                path: 'cat/:cid/job/add',
                name: AppRoute.addJob.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  final catId = state.params['cid']!;
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: EditJobScreen(catId: catId),
                  );
                },
              ),
              GoRoute(
                path: 'cat/:cid/job/:jid',
                name: AppRoute.job.name,
                pageBuilder: (context, state) {
                  final jid = state.params['jid']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: JobEntriesScreen(jobId: jid),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'entry/:eid',
                    name: AppRoute.editEntryViaJob.name,
                    pageBuilder: (context, state) {
                      final entryId = state.params['eid']!;
                      final entry = state.extra as Entry?;
                      return MaterialPage(
                        key: state.pageKey,
                        child: EntryScreen(
                          entryId: entryId,
                          entry: entry,
                        ),
                      );
                    },
                  ),
                ],
              ),
              GoRoute(
                path: 'cat/:cid/job/:jid/edit',
                name: AppRoute.editJob.name,
                pageBuilder: (context, state) {
                  final catId = state.params['cid'];
                  final jobId = state.params['jid'];
                  final job = state.extra as Job?;
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: EditJobScreen(
                      jobId: jobId,
                      job: job,
                      catId: catId,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/entries',
            name: AppRoute.entries.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const EntriesScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addEntry.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  final jid = state.params['jid']!;
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: EntryScreen(
                      jobId: jid,
                    ),
                  );
                },
              ),
              GoRoute(
                path: ':eid',
                name: AppRoute.editEntry.name,
                pageBuilder: (context, state) {
                  final entryId = state.params['eid']!;
                  final entry = state.extra as Entry?;
                  return MaterialPage(
                    key: state.pageKey,
                    child: EntryScreen(
                      entryId: entryId,
                      entry: entry,
                    ),
                  );
                },
              ),
            ],
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.profile.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CustomProfileScreen(),
            ),
          ),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
}
