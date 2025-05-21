import 'package:flutter/material.dart';

import '../../../l10n/app_localizations.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        AppLocalizations.of(context)!.dashboard,
        style: Theme.of(context).textTheme.displayLarge,
      ),
    );
  }
}
