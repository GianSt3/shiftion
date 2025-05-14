import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/person_dao.dart';
import '../../../data/shift_configuration_dao.dart';
import '../../../data/shift_dao.dart';
import '../../../domain/people/person_model.dart';
import '../../../domain/shift/shift_configuration_model.dart';
import '../../../domain/shift/shift_model.dart';

part 'schedule_state.dart';

class ScheduleCubit extends Cubit<ScheduleState> {
  final ShiftDao _shiftDao;
  final PersonDao _personDao;
  final ShiftConfigurationDao _shiftConfigurationDao;

  ScheduleCubit(this._shiftDao, this._personDao, this._shiftConfigurationDao)
      : super(ScheduleInitial());

  void init() {}

  Future<void> loadShifts() async {
    if (state is ScheduleLoaded) {
      (state as ScheduleLoaded).shifts;
    }

    try {
      emit(ScheduleLoading());
      final shiftEntities = await _shiftDao.findAllShifts();
      final shifts =
          shiftEntities.map((e) => ShiftModel.fromEntity(e)).toList();
      emit(ScheduleLoaded(shifts: shifts, people: [], configurations: []));
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> addShift(ShiftModel shift) async {
    try {
      await _shiftDao.insertShift(shift.toEntity());
      await loadShifts();
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }

  Future<void> deleteShift(int id) async {
    try {
      await _shiftDao.deleteShift(id);
      await loadShifts();
    } catch (e) {
      emit(ScheduleError(message: e.toString()));
    }
  }
}
