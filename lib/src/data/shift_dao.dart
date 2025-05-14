import 'package:floor/floor.dart';

import 'entities/shift_entity.dart';

@dao
abstract class ShiftDao {
  @Query('SELECT * FROM shifts')
  Future<List<ShiftEntity>> findAllShifts();

  @Query('SELECT * FROM shifts WHERE personId = :personId')
  Future<List<ShiftEntity>> findShiftsByPersonId(int personId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertShift(ShiftEntity shift);

  @Query('DELETE FROM shifts WHERE id = :id')
  Future<void> deleteShift(int id);
}
