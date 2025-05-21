part of 'configuration_detail_cubit.dart';

@immutable
sealed class ConfigurationDetailState {}

final class ConfigurationDetailInitial extends ConfigurationDetailState {}

final class ConfigurationDetailLoading extends ConfigurationDetailState {}

final class ConfigurationDetailLoaded extends ConfigurationDetailState {
  final ShiftConfigurationModel
      configuration; // Replace dynamic with your actual model type

  ConfigurationDetailLoaded(this.configuration);
}

final class ConfigurationDetailError extends ConfigurationDetailState {
  final String message;

  ConfigurationDetailError(this.message);
}
