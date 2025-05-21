import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/shift/shift_configuration_model.dart';
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
                      _ConfigurationDetailForm(configuration: configuration),
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

class _ConfigurationDetailForm extends StatefulWidget {
  final ShiftConfigurationModel
      configuration; // Replace dynamic with your model type if available

  const _ConfigurationDetailForm({required this.configuration});

  @override
  State<_ConfigurationDetailForm> createState() =>
      _ConfigurationDetailFormState();
}

class _ConfigurationDetailFormState extends State<_ConfigurationDetailForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _startTimeController;
  late TextEditingController _endTimeController;
  late bool _isOvernight;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.configuration.name);
    _startTimeController =
        TextEditingController(text: widget.configuration.startTime);
    _endTimeController =
        TextEditingController(text: widget.configuration.endTime);
    _isOvernight = widget.configuration.isOvernight;
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
    return Form(
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
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    context
                        .read<ConfigurationDetailCubit>()
                        .updateConfiguration(widget.configuration.copyWith(
                          name: _nameController.text,
                          startTime: _startTimeController.text,
                          endTime: _endTimeController.text,
                          isOvernight: _isOvernight,
                        ));
                  }
                },
                child: const Text("Update"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
