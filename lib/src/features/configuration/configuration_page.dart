import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../core/di/injection.dart';
import '../../data/shift_configuration_dao.dart';
import '../../domain/shift/shift_configuration_model.dart';
import 'bloc/shift_configuration_cubit.dart';
import 'detail/bloc/configuration_detail_cubit.dart';
import 'detail/configuration_detail_page.dart';
import 'form/configuration_form.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  @override
  void initState() {
    super.initState();
    context.read<ShiftConfigurationCubit>().loadShiftConfigurations();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Shift Configurations',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          ConfigurationForm(onSubmit: ({
            required String name,
            required String startTime,
            required String endTime,
            required bool isOvernight,
          }) {
            final configuration = ShiftConfigurationModel(
              name: name,
              startTime: startTime,
              endTime: endTime,
              isOvernight: isOvernight,
            );

            context
                .read<ShiftConfigurationCubit>()
                .addShiftConfiguration(configuration);
          }),
          const SizedBox(height: 24),
          const Divider(),
          Expanded(
            child:
                BlocBuilder<ShiftConfigurationCubit, ShiftConfigurationState>(
              builder: (context, state) {
                return switch (state) {
                  ShiftConfigurationLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  ShiftConfigurationLoaded(:final configurations) =>
                    ListView.builder(
                      itemCount: configurations.length,
                      itemBuilder: (context, index) {
                        final configuration = configurations[index];
                        return ListTile(
                          onTap: () async {
                            await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => ConfigurationDetailCubit(
                                    configurationDao:
                                        getIt<ShiftConfigurationDao>(),
                                  )..fetchConfiguration(configuration.id!),
                                  child: ConfigurationDetailPage(),
                                ),
                              ),
                            );
                            context
                                .read<ShiftConfigurationCubit>()
                                .loadShiftConfigurations();
                          },
                          title: Text(
                            configuration.name,
                            style: GoogleFonts.roboto(),
                          ),
                          subtitle: Text(
                              'Start: ${configuration.startTime}, End: ${configuration.endTime}, Overnight: ${configuration.isOvernight}'),
                          leading: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                configuration.startTime,
                                style: GoogleFonts.sourceCodePro(
                                  fontSize: 11,
                                ),
                              ),
                              Text(
                                configuration.endTime,
                                style: GoogleFonts.sourceCodePro(
                                  fontSize: 11,
                                ),
                              ),
                            ],
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context
                                  .read<ShiftConfigurationCubit>()
                                  .deleteShiftConfiguration(configuration.id!);
                            },
                          ),
                        );
                      },
                    ),
                  ShiftConfigurationError(:final message) => Center(
                      child: Text('Error: $message'),
                    ),
                  _ => const SizedBox.shrink(),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
