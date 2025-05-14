part of 'staff_detail_cubit.dart';

sealed class StaffDetailState extends Equatable {
  const StaffDetailState();

  @override
  List<Object?> get props => [];
}

final class StaffDetailInitial extends StaffDetailState {}

final class StaffDetailLoading extends StaffDetailState {}

final class StaffDetailLoaded extends StaffDetailState {
  final PersonModel person;

  const StaffDetailLoaded(this.person);

  @override
  List<Object?> get props => [person];
}

final class StaffDetailError extends StaffDetailState {
  final String message;

  const StaffDetailError(this.message);

  @override
  List<Object?> get props => [message];
}
