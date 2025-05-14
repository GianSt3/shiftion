import 'package:get_it/get_it.dart';

import '../../data/database.dart';
import '../../data/person_dao.dart';
import '../../data/shift_configuration_dao.dart';
import '../../data/shift_dao.dart';

final getIt = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  getIt.registerSingleton<AppDatabase>(database);

  // DAOs
  getIt.registerSingleton<PersonDao>(
    database.personDao,
  );
  getIt.registerSingleton<ShiftConfigurationDao>(
    database.shiftConfigurationDao,
  );
  getIt.registerSingleton<ShiftDao>(
    database.shiftDao,
  );
}
