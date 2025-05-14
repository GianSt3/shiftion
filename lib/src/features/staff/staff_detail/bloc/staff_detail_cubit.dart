import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../../data/person_dao.dart';
import '../../../../domain/people/person_model.dart';

part 'staff_detail_state.dart';

class StaffDetailCubit extends Cubit<StaffDetailState> {
  final PersonDao personDao;

  StaffDetailCubit({required this.personDao}) : super(StaffDetailInitial());

  Future<void> fetchPerson(int personId) async {
    emit(StaffDetailLoading());
    try {
      final person = await personDao.getPersonById(personId);
      emit(StaffDetailLoaded(PersonModel.fromEntity(person!)));
    } catch (e) {
      emit(StaffDetailError('Failed to load person details: $e'));
    }
  }
}
