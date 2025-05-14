import 'dart:async';

import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

import 'entities/converter.dart';
import 'entities/entities.dart';
import 'person_dao.dart';
import 'shift_configuration_dao.dart';
import 'shift_dao.dart';

part 'database.g.dart';

@Database(
  version: 1,
  entities: [PersonEntity, ShiftEntity, ShiftConfigurationEntity],
)
abstract class AppDatabase extends FloorDatabase {
  PersonDao get personDao;

  ShiftDao get shiftDao;

  ShiftConfigurationDao get shiftConfigurationDao;
}
