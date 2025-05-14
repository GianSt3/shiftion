import 'package:floor/floor.dart';

import 'converter.dart';
import 'person_entity.dart';
import 'shift_configuration_entity.dart';

@Entity(
  tableName: 'shifts',
  foreignKeys: [
    ForeignKey(
      childColumns: ['personId'],
      parentColumns: ['id'],
      entity: PersonEntity,
    ),
    ForeignKey(
      childColumns: ['shiftConfigurationId'],
      parentColumns: ['id'],
      entity: ShiftConfigurationEntity,
    ),
  ],
)
class ShiftEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int personId; // Links to a person
  final int shiftConfigurationId; // Links to a shift configuration

  @TypeConverters([DateTimeConverter])
  final DateTime date; // The specific date of the shift

  ShiftEntity({
    this.id,
    required this.personId,
    required this.shiftConfigurationId,
    required this.date,
  });
}
