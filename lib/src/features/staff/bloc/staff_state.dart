// staff_state.dart
part of 'staff_cubit.dart';

sealed class StaffState extends Equatable {
  const StaffState();
}

class StaffInitial extends StaffState {
  @override
  List<Object> get props => [];
}

class StaffLoading extends StaffState {
  @override
  List<Object> get props => [];
}

class StaffLoaded extends StaffState {
  final List<PersonModel> people;

  const StaffLoaded(this.people);

  @override
  List<Object> get props => [people];
}

class StaffError extends StaffState {
  final String message;

  const StaffError(this.message);

  @override
  List<Object> get props => [message];
}