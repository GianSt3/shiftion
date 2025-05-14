import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../configuration/configuration_page.dart';
import '../dashboard/dashboard_page.dart';
import '../schedule/schedule_page.dart';
import '../staff/staff_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _navigateToPage(int page) {
    _pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 240),
      curve: Curves.easeIn,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shiftion'),
        actions: [
          IconButton(icon: const Icon(Icons.settings), onPressed: () {}),
        ],
      ),
      body: Row(
        children: [
          NavigationRail(
            selectedIndex: _currentPage,
            onDestinationSelected: _navigateToPage,
            labelType: NavigationRailLabelType.all,
            destinations: [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard),
                label: Text(AppLocalizations.of(context)!.dashboard),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people),
                label: Text(AppLocalizations.of(context)!.staff),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.calendar_month),
                label: Text(AppLocalizations.of(context)!.schedule),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings),
                label: Text('Shifts'),
              ),
            ],
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (page) => setState(() => _currentPage = page),
              children: const [
                DashboardPage(),
                StaffPage(),
                SchedulePage(),
                ConfigurationPage(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
