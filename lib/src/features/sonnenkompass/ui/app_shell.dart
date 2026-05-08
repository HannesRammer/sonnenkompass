import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.child,
    super.key,
  });

  final Widget child;

  static const _destinations = <({String route, String label, IconData icon})>[
    (route: '/dashboard', label: 'Dashboard', icon: Icons.dashboard_outlined),
    (route: '/today', label: 'Heute', icon: Icons.today_outlined),
    (route: '/rays', label: 'Strahlen', icon: Icons.wb_sunny_outlined),
    (route: '/review', label: 'Review', icon: Icons.rate_review_outlined),
  ];

  @override
  Widget build(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();
    final index = _selectedIndex(location);
    final isWide = MediaQuery.sizeOf(context).width >= 980;

    if (isWide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: index,
              onDestinationSelected: (selected) {
                context.go(_destinations[selected].route);
              },
              labelType: NavigationRailLabelType.all,
              destinations: _destinations
                  .map(
                    (destination) => NavigationRailDestination(
                      icon: Icon(destination.icon),
                      label: Text(destination.label),
                    ),
                  )
                  .toList(),
            ),
            const VerticalDivider(width: 1),
            Expanded(child: child),
          ],
        ),
      );
    }

    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        selectedIndex: index,
        onDestinationSelected: (selected) {
          context.go(_destinations[selected].route);
        },
        destinations: _destinations
            .map(
              (destination) => NavigationDestination(
                icon: Icon(destination.icon),
                label: destination.label,
              ),
            )
            .toList(),
      ),
    );
  }

  int _selectedIndex(String location) {
    if (location.startsWith('/today')) return 1;
    if (location.startsWith('/rays') ||
        location.startsWith('/projects') ||
        location.startsWith('/ideas')) {
      return 2;
    }
    if (location.startsWith('/review')) return 3;
    return 0;
  }
}
