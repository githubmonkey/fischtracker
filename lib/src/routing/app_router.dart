import 'package:fischtracker/src/features/authentication/data/firebase_auth_repository.dart';
import 'package:fischtracker/src/features/authentication/presentation/account/account_screen.dart';
import 'package:fischtracker/src/features/authentication/presentation/email_password/email_password_sign_in_form_type.dart';
import 'package:fischtracker/src/features/authentication/presentation/email_password/email_password_sign_in_screen.dart';
import 'package:fischtracker/src/features/authentication/presentation/sign_in/sign_in_screen.dart';
import 'package:fischtracker/src/features/cats/domain/cat.dart';
import 'package:fischtracker/src/features/cats/presentation/cat_jobs_screen/cat_jobs_screen.dart';
import 'package:fischtracker/src/features/cats/presentation/cats_screen/cats_screen.dart';
import 'package:fischtracker/src/features/cats/presentation/edit_cat_screen/edit_cat_screen.dart';
import 'package:fischtracker/src/features/entries/domain/entry.dart';
import 'package:fischtracker/src/features/entries/presentation/entries_screen.dart';
import 'package:fischtracker/src/features/entries/presentation/entry_screen/entry_screen.dart';
import 'package:fischtracker/src/features/jobs/domain/job.dart';
import 'package:fischtracker/src/features/jobs/presentation/edit_job_screen/edit_job_screen.dart';
import 'package:fischtracker/src/features/jobs/presentation/job_entries_screen/job_entries_screen.dart';
import 'package:fischtracker/src/features/jobs/presentation/jobs_screen/jobs_screen.dart';
import 'package:fischtracker/src/features/onboarding/data/onboarding_repository.dart';
import 'package:fischtracker/src/features/onboarding/presentation/onboarding_screen.dart';
import 'package:fischtracker/src/routing/go_router_refresh_stream.dart';
import 'package:fischtracker/src/routing/scaffold_with_bottom_nav_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

// private navigators
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

enum AppRoute {
  onboarding,
  signIn,
  emailPassword,
  cats,
  cat,
  addCat,
  editCat,
  addJobForCat,
  jobs,
  job,
  jobdirect,
  addJob,
  editJob,
  entry,
  addEntry,
  editEntry,
  entries,
  account,
}

final goRouterProvider = Provider<GoRouter>((ref) {
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
          return '/cats';
        }
      } else {
        if (state.subloc.startsWith('/cats') ||
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
          child: const SignInScreen(),
        ),
        routes: [
          GoRoute(
            path: 'emailPassword',
            name: AppRoute.emailPassword.name,
            pageBuilder: (context, state) => MaterialPage(
              key: state.pageKey,
              fullscreenDialog: true,
              child: const EmailPasswordSignInScreen(
                formType: EmailPasswordSignInFormType.signIn,
              ),
            ),
          ),
        ],
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) {
          return ScaffoldWithBottomNavBar(child: child);
        },
        routes: [
          GoRoute(
            path: '/cats',
            name: AppRoute.cats.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const CatsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
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
                path: ':cid',
                name: AppRoute.cat.name,
                pageBuilder: (context, state) {
                  final id = state.params['cid']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: CatJobsScreen(catId: id),
                  );
                },
                routes: [
                  GoRoute(
                    path: 'jobs/add',
                    name: AppRoute.addJobForCat.name,
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
                    path: 'jobs/:jid',
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
                        path: 'entries/add',
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
                        path: 'entries/:eid',
                        name: AppRoute.entry.name,
                        pageBuilder: (context, state) {
                          final jobId = state.params['jid']!;
                          final entryId = state.params['eid']!;
                          final entry = state.extra as Entry?;
                          return MaterialPage(
                            key: state.pageKey,
                            child: EntryScreen(
                              jobId: jobId,
                              entryId: entryId,
                              entry: entry,
                            ),
                          );
                        },
                      ),
                      GoRoute(
                        path: 'edit',
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
                    path: 'edit',
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
                ],
              ),
            ],
          ),
          GoRoute(
            path: '/jobs',
            name: AppRoute.jobs.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const JobsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add',
                name: AppRoute.addJob.name,
                parentNavigatorKey: _rootNavigatorKey,
                pageBuilder: (context, state) {
                  return MaterialPage(
                    key: state.pageKey,
                    fullscreenDialog: true,
                    child: const EditJobScreen(catId: null),
                  );
                },
              ),
               GoRoute(
                path: ':jid',
                name: AppRoute.jobdirect.name,
                pageBuilder: (context, state) {
                  final jid = state.params['jid']!;
                  return MaterialPage(
                    key: state.pageKey,
                    child: JobEntriesScreen(jobId: jid),
                  );
                },
              //   routes: [
              //     GoRoute(
              //       path: 'entries/add',
              //       name: AppRoute.addEntry.name,
              //       parentNavigatorKey: _rootNavigatorKey,
              //       pageBuilder: (context, state) {
              //         final jobId = state.params['id']!;
              //         return MaterialPage(
              //           key: state.pageKey,
              //           fullscreenDialog: true,
              //           child: EntryScreen(
              //             jobId: jobId,
              //           ),
              //         );
              //       },
              //     ),
              //     GoRoute(
              //       path: 'entries/:eid',
              //       name: AppRoute.entry.name,
              //       pageBuilder: (context, state) {
              //         final jobId = state.params['id']!;
              //         final entryId = state.params['eid']!;
              //         final entry = state.extra as Entry?;
              //         return MaterialPage(
              //           key: state.pageKey,
              //           child: EntryScreen(
              //             jobId: jobId,
              //             entryId: entryId,
              //             entry: entry,
              //           ),
              //         );
              //       },
              //     ),
              //     GoRoute(
              //       path: 'edit',
              //       name: AppRoute.editJob.name,
              //       pageBuilder: (context, state) {
              //         final jobId = state.params['id'];
              //         final job = state.extra as Job?;
              //         final catId = job?.catId;
              //         return MaterialPage(
              //           key: state.pageKey,
              //           fullscreenDialog: true,
              //           child: EditJobScreen(jobId: jobId, job: job, catId: catId,),
              //         );
              //       },
              //     ),
              //   ],
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
          ),
          GoRoute(
            path: '/account',
            name: AppRoute.account.name,
            pageBuilder: (context, state) => NoTransitionPage(
              key: state.pageKey,
              child: const AccountScreen(),
            ),
          ),
        ],
      ),
    ],
    //errorBuilder: (context, state) => const NotFoundScreen(),
  );
});
