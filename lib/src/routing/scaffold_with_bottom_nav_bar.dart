import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:fischtracker/src/localization/string_hardcoded.dart';
import 'package:fischtracker/src/routing/app_router.dart';

// This is a temporary implementation
// TODO: Implement a better solution once this PR is merged:
// https://github.com/flutter/packages/pull/2650
class ScaffoldWithBottomNavBar extends StatefulWidget {
  const ScaffoldWithBottomNavBar({super.key, required this.child});
  final Widget child;

  @override
  State<ScaffoldWithBottomNavBar> createState() =>
      _ScaffoldWithBottomNavBarState();
}

class _ScaffoldWithBottomNavBarState extends State<ScaffoldWithBottomNavBar> {
  // used for the currentIndex argument of BottomNavigationBar
  int _selectedIndex = 0;

  void _tap(BuildContext context, int index) {
    if (index == _selectedIndex) {
      // If the tab hasn't changed, do nothing
      return;
    }
    setState(() => _selectedIndex = index);
    if (index == 0) {
      // Note: this won't remember the previous state of the route
      // More info here:
      // https://github.com/flutter/flutter/issues/99124
      context.goNamed(AppRoute.timers.name);
    } else if (index == 1) {
      context.goNamed(AppRoute.topo.name);
      // } else if (index == 2) {
      //   context.goNamed(AppRoute.cats.name);
      // } else if (index == 3) {
      //   context.goNamed(AppRoute.jobs.name);
    } else if (index == 2) {
      context.goNamed(AppRoute.entries.name);
    } else if (index == 3) {
      context.goNamed(AppRoute.profile.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        items: [
          // products
          BottomNavigationBarItem(
            icon: const Icon(Icons.punch_clock_rounded),
            label: 'Timers'.hardcoded,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.account_tree),
            label: 'Topology'.hardcoded,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.view_headline),
            label: 'Entries'.hardcoded,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Account'.hardcoded,
          ),
        ],
        onTap: (index) => _tap(context, index),
      ),
    );
  }
}
