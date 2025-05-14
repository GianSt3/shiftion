import 'package:floor/floor.dart';

import 'entities/person_entity.dart';

@dao
abstract class PersonDao {
  @Query('SELECT * FROM people')
  Future<List<PersonEntity>> getAllPersons();

  @Query('SELECT * FROM people WHERE id = :id')
  Future<PersonEntity?> getPersonById(int id);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPerson(PersonEntity person);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updatePerson(PersonEntity person);

  @delete
  Future<void> deletePerson(PersonEntity person);
}
