import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import 'src/core/di/injection.dart';
import 'src/data/person_dao.dart';
import 'src/data/shift_configuration_dao.dart';
import 'src/data/shift_dao.dart';
import 'src/features/configuration/bloc/shift_configuration_cubit.dart';
import 'src/features/home/home_page.dart';
import 'src/features/schedule/bloc/schedule_cubit.dart';
import 'src/features/staff/bloc/staff_cubit.dart';
import 'src/theme/windows_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDependencies();

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      theme: windowsTheme(),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => StaffCubit(getIt<PersonDao>()),
          ),
          BlocProvider(
            create: (context) =>
                ShiftConfigurationCubit(getIt<ShiftConfigurationDao>()),
          ),
          BlocProvider(
            create: (context) => ScheduleCubit(
              getIt<ShiftDao>(),
              getIt<PersonDao>(),
              getIt<ShiftConfigurationDao>(),
            ),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
