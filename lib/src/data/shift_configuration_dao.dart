import 'package:floor/floor.dart';

import 'entities/shift_configuration_entity.dart';

@dao
abstract class ShiftConfigurationDao {
  @Query('SELECT * FROM shift_configurations')
  Future<List<ShiftConfigurationEntity>> findAllConfigurations();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertConfiguration(ShiftConfigurationEntity configuration);

  @Query('DELETE FROM shift_configurations WHERE id = :id')
  Future<void> deleteConfiguration(int id);

  @Query('SELECT * FROM shift_configurations WHERE id = :id')
  Future<ShiftConfigurationEntity?> getConfigurationById(int id);

  @Update(onConflict: OnConflictStrategy.replace)
  Future<void> updateConfiguration(ShiftConfigurationEntity configuration);
}
