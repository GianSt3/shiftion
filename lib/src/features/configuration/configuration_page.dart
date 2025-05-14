import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/shift/shift_configuration_model.dart';
import 'bloc/shift_configuration_cubit.dart';

class ConfigurationPage extends StatefulWidget {
  const ConfigurationPage({super.key});

  @override
  State<ConfigurationPage> createState() => _ConfigurationPageState();
}

class _ConfigurationPageState extends State<ConfigurationPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _startTimeController = TextEditingController();
  final _endTimeController = TextEditingController();
  bool _isOvernight = false;

  @override
  void initState() {
    super.initState();
    context.read<ShiftConfigurationCubit>().loadShiftConfigurations();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _startTimeController.dispose();
    _endTimeController.dispose();
    super.dispose();
  }

  Future<void> _selectTime(
      BuildContext context, TextEditingController controller) async {
    final timeOfDay = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timeOfDay != null) {
      final formattedTime = timeOfDay.format(context);
      controller.text = formattedTime;
    }
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
          Form(
            key: _formKey,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 400,
                      child: TextFormField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          labelText: 'Configuration Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Name is required";
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _startTimeController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'Start Time',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => _selectTime(context, _startTimeController),
                      ),
                    ),
                    const SizedBox(width: 16),
                    SizedBox(
                      width: 100,
                      child: TextFormField(
                        controller: _endTimeController,
                        readOnly: true,
                        decoration: const InputDecoration(
                          labelText: 'End Time',
                          border: OutlineInputBorder(),
                        ),
                        onTap: () => _selectTime(context, _endTimeController),
                      ),
                    ),
                    Row(
                      children: [
                        Checkbox(
                          value: _isOvernight,
                          onChanged: (value) {
                            setState(() {
                              _isOvernight = value ?? false;
                            });
                          },
                        ),
                        const Text('Is Overnight'),
                      ],
                    ),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          final configuration = ShiftConfigurationModel(
                            name: _nameController.text,
                            startTime: _startTimeController.text,
                            endTime: _endTimeController.text,
                            isOvernight: _isOvernight,
                          );

                          context
                              .read<ShiftConfigurationCubit>()
                              .addShiftConfiguration(configuration);
                          _nameController.clear();
                          _startTimeController.clear();
                          _endTimeController.clear();
                          setState(() {
                            _isOvernight = false;
                          });
                        }
                      },
                      child: const Text("Add"),
                    ),
                  ],
                ),
              ],
            ),
          ),
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
