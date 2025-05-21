// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PersonDao? _personDaoInstance;

  ShiftDao? _shiftDaoInstance;

  ShiftConfigurationDao? _shiftConfigurationDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `people` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `isEmployee` INTEGER NOT NULL, `isFreelance` INTEGER NOT NULL, `isIntern` INTEGER NOT NULL)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `shifts` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `personId` INTEGER NOT NULL, `shiftConfigurationId` INTEGER NOT NULL, `date` INTEGER NOT NULL, FOREIGN KEY (`personId`) REFERENCES `people` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION, FOREIGN KEY (`shiftConfigurationId`) REFERENCES `shift_configurations` (`id`) ON UPDATE NO ACTION ON DELETE NO ACTION)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `shift_configurations` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `name` TEXT NOT NULL, `startTime` TEXT NOT NULL, `endTime` TEXT NOT NULL, `isOvernight` INTEGER NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PersonDao get personDao {
    return _personDaoInstance ??= _$PersonDao(database, changeListener);
  }

  @override
  ShiftDao get shiftDao {
    return _shiftDaoInstance ??= _$ShiftDao(database, changeListener);
  }

  @override
  ShiftConfigurationDao get shiftConfigurationDao {
    return _shiftConfigurationDaoInstance ??=
        _$ShiftConfigurationDao(database, changeListener);
  }
}

class _$PersonDao extends PersonDao {
  _$PersonDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _personEntityInsertionAdapter = InsertionAdapter(
            database,
            'people',
            (PersonEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isEmployee': item.isEmployee ? 1 : 0,
                  'isFreelance': item.isFreelance ? 1 : 0,
                  'isIntern': item.isIntern ? 1 : 0
                }),
        _personEntityUpdateAdapter = UpdateAdapter(
            database,
            'people',
            ['id'],
            (PersonEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isEmployee': item.isEmployee ? 1 : 0,
                  'isFreelance': item.isFreelance ? 1 : 0,
                  'isIntern': item.isIntern ? 1 : 0
                }),
        _personEntityDeletionAdapter = DeletionAdapter(
            database,
            'people',
            ['id'],
            (PersonEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'isEmployee': item.isEmployee ? 1 : 0,
                  'isFreelance': item.isFreelance ? 1 : 0,
                  'isIntern': item.isIntern ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<PersonEntity> _personEntityInsertionAdapter;

  final UpdateAdapter<PersonEntity> _personEntityUpdateAdapter;

  final DeletionAdapter<PersonEntity> _personEntityDeletionAdapter;

  @override
  Future<List<PersonEntity>> getAllPersons() async {
    return _queryAdapter.queryList('SELECT * FROM people',
        mapper: (Map<String, Object?> row) => PersonEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            isEmployee: (row['isEmployee'] as int) != 0,
            isFreelance: (row['isFreelance'] as int) != 0,
            isIntern: (row['isIntern'] as int) != 0));
  }

  @override
  Future<PersonEntity?> getPersonById(int id) async {
    return _queryAdapter.query('SELECT * FROM people WHERE id = ?1',
        mapper: (Map<String, Object?> row) => PersonEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            isEmployee: (row['isEmployee'] as int) != 0,
            isFreelance: (row['isFreelance'] as int) != 0,
            isIntern: (row['isIntern'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> insertPerson(PersonEntity person) async {
    await _personEntityInsertionAdapter.insert(
        person, OnConflictStrategy.replace);
  }

  @override
  Future<void> updatePerson(PersonEntity person) async {
    await _personEntityUpdateAdapter.update(person, OnConflictStrategy.replace);
  }

  @override
  Future<void> deletePerson(PersonEntity person) async {
    await _personEntityDeletionAdapter.delete(person);
  }
}

class _$ShiftDao extends ShiftDao {
  _$ShiftDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _shiftEntityInsertionAdapter = InsertionAdapter(
            database,
            'shifts',
            (ShiftEntity item) => <String, Object?>{
                  'id': item.id,
                  'personId': item.personId,
                  'shiftConfigurationId': item.shiftConfigurationId,
                  'date': _dateTimeConverter.encode(item.date)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShiftEntity> _shiftEntityInsertionAdapter;

  @override
  Future<List<ShiftEntity>> findAllShifts() async {
    return _queryAdapter.queryList('SELECT * FROM shifts',
        mapper: (Map<String, Object?> row) => ShiftEntity(
            id: row['id'] as int?,
            personId: row['personId'] as int,
            shiftConfigurationId: row['shiftConfigurationId'] as int,
            date: _dateTimeConverter.decode(row['date'] as int)));
  }

  @override
  Future<List<ShiftEntity>> findShiftsByPersonId(int personId) async {
    return _queryAdapter.queryList('SELECT * FROM shifts WHERE personId = ?1',
        mapper: (Map<String, Object?> row) => ShiftEntity(
            id: row['id'] as int?,
            personId: row['personId'] as int,
            shiftConfigurationId: row['shiftConfigurationId'] as int,
            date: _dateTimeConverter.decode(row['date'] as int)),
        arguments: [personId]);
  }

  @override
  Future<void> deleteShift(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM shifts WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insertShift(ShiftEntity shift) async {
    await _shiftEntityInsertionAdapter.insert(
        shift, OnConflictStrategy.replace);
  }
}

class _$ShiftConfigurationDao extends ShiftConfigurationDao {
  _$ShiftConfigurationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _shiftConfigurationEntityInsertionAdapter = InsertionAdapter(
            database,
            'shift_configurations',
            (ShiftConfigurationEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'isOvernight': item.isOvernight ? 1 : 0
                }),
        _shiftConfigurationEntityUpdateAdapter = UpdateAdapter(
            database,
            'shift_configurations',
            ['id'],
            (ShiftConfigurationEntity item) => <String, Object?>{
                  'id': item.id,
                  'name': item.name,
                  'startTime': item.startTime,
                  'endTime': item.endTime,
                  'isOvernight': item.isOvernight ? 1 : 0
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<ShiftConfigurationEntity>
      _shiftConfigurationEntityInsertionAdapter;

  final UpdateAdapter<ShiftConfigurationEntity>
      _shiftConfigurationEntityUpdateAdapter;

  @override
  Future<List<ShiftConfigurationEntity>> findAllConfigurations() async {
    return _queryAdapter.queryList('SELECT * FROM shift_configurations',
        mapper: (Map<String, Object?> row) => ShiftConfigurationEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            isOvernight: (row['isOvernight'] as int) != 0));
  }

  @override
  Future<void> deleteConfiguration(int id) async {
    await _queryAdapter.queryNoReturn(
        'DELETE FROM shift_configurations WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<ShiftConfigurationEntity?> getConfigurationById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM shift_configurations WHERE id = ?1',
        mapper: (Map<String, Object?> row) => ShiftConfigurationEntity(
            id: row['id'] as int?,
            name: row['name'] as String,
            startTime: row['startTime'] as String,
            endTime: row['endTime'] as String,
            isOvernight: (row['isOvernight'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> insertConfiguration(
      ShiftConfigurationEntity configuration) async {
    await _shiftConfigurationEntityInsertionAdapter.insert(
        configuration, OnConflictStrategy.replace);
  }

  @override
  Future<void> updateConfiguration(
      ShiftConfigurationEntity configuration) async {
    await _shiftConfigurationEntityUpdateAdapter.update(
        configuration, OnConflictStrategy.replace);
  }
}

// ignore_for_file: unused_element
final _dateTimeConverter = DateTimeConverter();
