import '../../data/entities/shift_entity.dart';

class ShiftModel {
  final int? id;
  final int personId;
  final int shiftConfigurationId;
  final DateTime date;

  const ShiftModel({
    this.id,
    required this.personId,
    required this.shiftConfigurationId,
    required this.date,
  });

  factory ShiftModel.fromEntity(ShiftEntity entity) {
    return ShiftModel(
      id: entity.id,
      personId: entity.personId,
      shiftConfigurationId: entity.shiftConfigurationId,
      date: entity.date,
    );
  }

  ShiftEntity toEntity() {
    return ShiftEntity(
      id: id,
      personId: personId,
      shiftConfigurationId: shiftConfigurationId,
      date: date,
    );
  }
}
