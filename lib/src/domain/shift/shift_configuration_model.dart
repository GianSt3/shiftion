import 'package:intl/intl.dart';

import '../../data/entities/shift_configuration_entity.dart';

class ShiftConfigurationModel {
  final int? id;
  final String name;
  String startTime; // Format: "HH:mm"
  String endTime; // Format: "HH:mm"
  final bool isOvernight;

  ShiftConfigurationModel({
    this.id,
    required this.name,
    required this.startTime,
    required this.endTime,
    required this.isOvernight,
  });

  void setStartTime(DateTime time) {
    startTime = DateFormat('HH:mm').format(time);
  }

  void setEndTime(DateTime time) {
    endTime = DateFormat('HH:mm').format(time);
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'startTime': startTime,
      'endTime': endTime,
      'isOvernight': isOvernight ? 1 : 0,
    };
  }

  ShiftConfigurationModel copyWith({
    int? id,
    String? name,
    String? startTime,
    String? endTime,
    bool? isOvernight,
  }) {
    return ShiftConfigurationModel(
      id: id ?? this.id,
      name: name ?? this.name,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
      isOvernight: isOvernight ?? this.isOvernight,
    );
  }

  factory ShiftConfigurationModel.fromMap(Map<String, dynamic> map) {
    return ShiftConfigurationModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      isOvernight: map['isOvernight'] == 1,
    );
  }

  ShiftConfigurationEntity toEntity() {
    return ShiftConfigurationEntity(
      id: id,
      name: name,
      startTime: startTime,
      endTime: endTime,
      isOvernight: isOvernight,
    );
  }

  static ShiftConfigurationModel fromEntity(ShiftConfigurationEntity entity) {
    return ShiftConfigurationModel(
      id: entity.id,
      name: entity.name,
      startTime: entity.startTime,
      endTime: entity.endTime,
      isOvernight: entity.isOvernight,
    );
  }
}
