import 'package:flutter/material.dart';

import '../../data/entities/availability_entity.dart';

class AvailabilityModel {
  final int? id;
  final int personId;
  final List<DateTimeRange> unavailableRanges;

  AvailabilityModel({
    this.id,
    required this.personId,
    required this.unavailableRanges,
  });

  factory AvailabilityModel.fromEntity(AvailabilityEntity entity) {
    return AvailabilityModel(
      id: entity.id,
      personId: entity.personId,
      unavailableRanges: entity.unavailableRanges.map((range) {
        final decoded = DateTimeRange(
          start: DateTime.parse(range.split('|')[0]),
          end: DateTime.parse(range.split('|')[1]),
        );
        return decoded;
      }).toList(),
    );
  }

  AvailabilityEntity toEntity() {
    return AvailabilityEntity(
      id: id,
      personId: personId,
      unavailableRanges: unavailableRanges.map((range) {
        return '${range.start.toIso8601String()}|${range.end.toIso8601String()}';
      }).toList(),
    );
  }
}
