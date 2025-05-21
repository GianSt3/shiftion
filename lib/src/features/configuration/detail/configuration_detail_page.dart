import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../form/configuration_form.dart';
import 'bloc/configuration_detail_cubit.dart';

class ConfigurationDetailPage extends StatelessWidget {
  const ConfigurationDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigurationDetailCubit, ConfigurationDetailState>(
      builder: (context, state) {
        // Replace with your state handling logic
        return switch (state) {
          ConfigurationDetailInitial() =>
            const Center(child: CircularProgressIndicator()),
          ConfigurationDetailLoading() =>
            const Center(child: CircularProgressIndicator()),
          ConfigurationDetailError(message: final message) =>
            Center(child: Text(message)),
          ConfigurationDetailLoaded(configuration: final configuration) =>
            Scaffold(
              appBar: AppBar(title: Text(configuration.name)),
              body: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Edit Configuration',
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 16),
                      ConfigurationForm(
                          initialName: configuration.name,
                          initialStartTime: configuration.startTime,
                          initialEndTime: configuration.endTime,
                          initialIsOvernight: configuration.isOvernight,
                          onSubmit: ({
                            required String name,
                            required String startTime,
                            required String endTime,
                            required bool isOvernight,
                          }) {
                            context
                                .read<ConfigurationDetailCubit>()
                                .updateConfiguration(configuration.copyWith(
                                  name: name,
                                  startTime: startTime,
                                  endTime: endTime,
                                  isOvernight: isOvernight,
                                ));
                          }),
                    ],
                  ),
                ),
              ),
            ),
        };
      },
    );
  }
}
