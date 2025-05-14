import 'dart:convert';

import 'package:floor/floor.dart';
import 'package:flutter/material.dart';

class DateTimeConverter extends TypeConverter<DateTime, int> {
  @override
  DateTime decode(int databaseValue) {
    return DateTime.fromMillisecondsSinceEpoch(databaseValue);
  }

  @override
  int encode(DateTime value) {
    return value.millisecondsSinceEpoch;
  }
}

class DateTimeRangeListConverter
    extends TypeConverter<List<DateTimeRange>, List<String>> {
  @override
  List<DateTimeRange> decode(List<String> databaseValue) {
    return databaseValue.map((range) {
      final decoded = jsonDecode(range);
      return DateTimeRange(
        start: DateTime.parse(decoded['start']),
        end: DateTime.parse(decoded['end']),
      );
    }).toList();
  }

  @override
  List<String> encode(List<DateTimeRange> value) {
    return value
        .map((range) => jsonEncode({
              'start': range.start.toIso8601String(),
              'end': range.end.toIso8601String(),
            }))
        .toList();
  }
}
