import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../data/shift_configuration_dao.dart';
import '../../../domain/shift/shift_configuration_model.dart';

part 'shift_configuration_state.dart';

class ShiftConfigurationCubit extends Cubit<ShiftConfigurationState> {
  final ShiftConfigurationDao _shiftConfigurationDao;

  ShiftConfigurationCubit(this._shiftConfigurationDao)
      : super(ShiftConfigurationInitial());

  Future<void> loadShiftConfigurations() async {
    try {
      emit(ShiftConfigurationLoading());
      final configurations =
          await _shiftConfigurationDao.findAllConfigurations();
      emit(ShiftConfigurationLoaded(
          configurations: configurations
              .map((e) => ShiftConfigurationModel.fromEntity(e))
              .toList()));
    } catch (e) {
      emit(ShiftConfigurationError(message: e.toString()));
    }
  }

  Future<void> addShiftConfiguration(
      ShiftConfigurationModel configuration) async {
    try {
      await _shiftConfigurationDao
          .insertConfiguration(configuration.toEntity());
      await loadShiftConfigurations();
    } catch (e) {
      emit(ShiftConfigurationError(message: e.toString()));
    }
  }

  Future<void> deleteShiftConfiguration(int id) async {
    try {
      await _shiftConfigurationDao.deleteConfiguration(id);
      await loadShiftConfigurations();
    } catch (e) {
      emit(ShiftConfigurationError(message: e.toString()));
    }
  }
}
