import 'package:floor/floor.dart';

@Entity(tableName: 'people')
class PersonEntity {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final bool isEmployee;
  final bool isFreelance;
  final bool isIntern;

  PersonEntity({
    this.id,
    required this.name,
    required this.isEmployee,
    this.isFreelance = false,
    this.isIntern = false,
  });
}
