part of 'schedule_cubit.dart';

sealed class ScheduleState extends Equatable {
  const ScheduleState();

  @override
  List<Object?> get props => [];
}

class ScheduleInitial extends ScheduleState {}

class ScheduleLoading extends ScheduleState {}

class ScheduleLoaded extends ScheduleState {
  final List<ShiftModel> shifts;
  final List<PersonModel> people;
  final List<ShiftConfigurationModel> configurations;

  const ScheduleLoaded({
    required this.shifts,
    required this.people,
    required this.configurations,
  });

  ScheduleLoaded copyWith({
    List<ShiftModel>? shifts,
    List<PersonModel>? people,
    List<ShiftConfigurationModel>? configurations,
  }) {
    return ScheduleLoaded(
      shifts: shifts ?? this.shifts,
      people: people ?? this.people,
      configurations: configurations ?? this.configurations,
    );
  }

  @override
  List<Object?> get props => [shifts, people, configurations];
}

class ScheduleError extends ScheduleState {
  final String message;

  const ScheduleError({required this.message});

  @override
  List<Object?> get props => [message];
}
