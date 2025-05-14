import 'package:floor/floor.dart';

import 'converter.dart';
import 'person_entity.dart';

@Entity(
  tableName: 'availability',
  foreignKeys: [
    ForeignKey(
      childColumns: ['personId'],
      parentColumns: ['id'],
      entity: PersonEntity,
    ),
  ],
)
class AvailabilityEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int personId; // Links to a person

  @TypeConverters([DateTimeRangeListConverter])
  final List<String> unavailableRanges; // Serialized DateTime ranges

  AvailabilityEntity({
    this.id,
    required this.personId,
    required this.unavailableRanges,
  });
}
