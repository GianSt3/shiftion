import 'package:floor/floor.dart';

@Entity(tableName: 'shift_configurations')
class ShiftConfigurationEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String startTime; // Format: "HH:mm"
  final String endTime; // Format: "HH:mm"
  final bool isOvernight; // Indicates if the shift spans across midnight

  ShiftConfigurationEntity({
    this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    this.isOvernight = false,
  });
}
