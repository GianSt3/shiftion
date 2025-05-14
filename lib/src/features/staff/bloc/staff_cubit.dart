// staff_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/person_dao.dart';
import '../../../domain/people/person_model.dart';

part 'staff_state.dart';

class StaffCubit extends Cubit<StaffState> {
  final PersonDao _personDao;

  StaffCubit(this._personDao) : super(StaffInitial());

  Future<void> loadPeople() async {
    emit(StaffLoading());
    try {
      final people = await _personDao.getAllPersons();
      emit(StaffLoaded(people
          .map(
            (e) => PersonModel(
                id: e.id,
                name: e.name,
                isEmployee: e.isEmployee,
                isFreelance: e.isFreelance,
                isIntern: e.isIntern),
          )
          .toList()));
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }

  Future<void> addPerson(PersonModel person) async {
    try {
      await _personDao.insertPerson(person.toEntity());
      await loadPeople();
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }

  Future<void> deletePerson(PersonModel person) async {
    try {
      await _personDao.deletePerson(person.toEntity());
      await loadPeople();
    } catch (e) {
      emit(StaffError(e.toString()));
    }
  }
}
