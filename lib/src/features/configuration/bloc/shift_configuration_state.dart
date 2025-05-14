part of 'shift_configuration_cubit.dart';

sealed class ShiftConfigurationState extends Equatable {
  const ShiftConfigurationState();

  @override
  List<Object?> get props => [];
}

final class ShiftConfigurationInitial extends ShiftConfigurationState {}

final class ShiftConfigurationLoading extends ShiftConfigurationState {}

final class ShiftConfigurationLoaded extends ShiftConfigurationState {
  final List<ShiftConfigurationModel> configurations;

  const ShiftConfigurationLoaded({required this.configurations});

  @override
  List<Object?> get props => [configurations];
}

final class ShiftConfigurationError extends ShiftConfigurationState {
  final String message;

  const ShiftConfigurationError({required this.message});

  @override
  List<Object?> get props => [message];
}
