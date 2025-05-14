import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

import '../configuration/bloc/shift_configuration_cubit.dart';
import '../staff/bloc/staff_cubit.dart';

class SchedulePage extends StatefulWidget {
  const SchedulePage({super.key});

  @override
  State<SchedulePage> createState() => _SchedulePageState();
}

class _SchedulePageState extends State<SchedulePage> {
  late final List<DateTime> nextWeekDays;

  @override
  void initState() {
    super.initState();
    context.read<StaffCubit>().loadPeople();
    context.read<ShiftConfigurationCubit>().loadShiftConfigurations();

    final now = DateTime.now();
    nextWeekDays = List.generate(
      7,
      (index) => now.add(Duration(days: index + 1)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShiftConfigurationCubit, ShiftConfigurationState>(
      builder: (context, shiftState) {
        return BlocBuilder<StaffCubit, StaffState>(
          builder: (context, staffState) {
            return switch (staffState) {
              StaffInitial() => Text('initial'),
              StaffLoading() => const CircularProgressIndicator(),
              StaffLoaded() => SingleChildScrollView(
                  child: Column(
                    children: [
                      Table(
                        border: TableBorder.all(
                          color: Colors.grey,
                          width: 1,
                          style: BorderStyle.solid,
                        ),
                        columnWidths: const {
                          0: FixedColumnWidth(150),
                        },
                        children: [
                          // Header row with days of the next week
                          TableRow(
                            children: [
                              const TableCell(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'People',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              ...nextWeekDays.map(
                                (day) => TableCell(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(
                                      DateFormat('EEE, MMM d').format(day),
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Rows for each person
                          ...staffState.people.map((person) => TableRow(
                                children: [
                                  TableCell(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            person.name,
                                            style: GoogleFonts.roboto(
                                                fontSize: 16),
                                          ),
                                          Text(
                                            person.roleText,
                                            style: GoogleFonts.roboto(),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  ...nextWeekDays.map(
                                    (day) => TableCell(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: switch (shiftState) {
                                          ShiftConfigurationInitial() =>
                                            const Text('initial'),
                                          ShiftConfigurationLoading() =>
                                            const CircularProgressIndicator(),
                                          ShiftConfigurationLoaded() => Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: shiftState
                                                  .configurations
                                                  .map(
                                                    (shift) => OutlinedButton(
                                                      style: OutlinedButton
                                                          .styleFrom(
                                                        shape:
                                                            RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(2),
                                                        ),
                                                        backgroundColor:
                                                            Colors.white,
                                                        side: const BorderSide(
                                                            color: Colors
                                                                .blueGrey),
                                                      ),
                                                      onPressed: () {
                                                        // Handle shift selection
                                                      },
                                                      child: Text(
                                                        '${shift.name} (${shift.startTime} - ${shift.endTime})',
                                                        style: const TextStyle(
                                                            fontSize: 12),
                                                      ),
                                                    ),
                                                  )
                                                  .toList(),
                                            ),
                                          ShiftConfigurationError() =>
                                            const Text('Error loading shifts'),
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              StaffError() => const Text('Error loading staff'),
            };
          },
        );
      },
    );
  }
}
