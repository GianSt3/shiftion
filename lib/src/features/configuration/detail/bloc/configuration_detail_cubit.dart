import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../data/shift_configuration_dao.dart';
import '../../../../domain/shift/shift_configuration_model.dart';

part 'configuration_detail_state.dart';

class ConfigurationDetailCubit extends Cubit<ConfigurationDetailState> {
  final ShiftConfigurationDao configurationDao;

  ConfigurationDetailCubit({required this.configurationDao})
      : super(ConfigurationDetailInitial());

  Future<void> fetchConfiguration(int configurationId) async {
    emit(ConfigurationDetailLoading());
    try {
      final configuration =
          await configurationDao.getConfigurationById(configurationId);
      emit(ConfigurationDetailLoaded(
          ShiftConfigurationModel.fromEntity(configuration!)));
    } catch (e) {
      emit(
          ConfigurationDetailError('Failed to load configuration details: $e'));
    }
  }

  Future<void> updateConfiguration(ShiftConfigurationModel updatedData) async {
    emit(ConfigurationDetailLoading());
    try {
      await configurationDao.updateConfiguration(updatedData.toEntity());
      final configuration =
          await configurationDao.getConfigurationById(updatedData.id!);
      emit(ConfigurationDetailLoaded(
          ShiftConfigurationModel.fromEntity(configuration!)));
    } catch (e) {
      emit(ConfigurationDetailError('Failed to update configuration: $e'));
    }
  }
}
