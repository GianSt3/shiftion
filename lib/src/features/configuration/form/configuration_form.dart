import 'package:flutter/material.dart';

class ConfigurationForm extends StatefulWidget {
  final String? initialName;
  final String? initialStartTime;
  final String? initialEndTime;
  final bool initialIsOvernight;
  final void Function({
    required String name,
    required String startTime,
    required String endTime,
    required bool isOvernight,
  }) onSubmit;

  const ConfigurationForm({
    super.key,
    this.initialName,
    this.initialStartTime,
    this.initialEndTime,
    this.initialIsOvernight = false,
    required this.onSubmit,
  });

  @override
  State<ConfigurationForm> createState() => _ConfigurationFormState();
}

class _ConfigurationFormState extends State<ConfigurationForm> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _startTimeController;
  late final TextEditingController _endTimeController;
  late bool _isOvernight;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName ?? '');
    _startTimeController =
        TextEditingController(text: widget.initialStartTime ?? '');
    _endTimeController =
        TextEditingController(text: widget.initialEndTime ?? '');
    _isOvernight = widget.initialIsOvernight;
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
      controller.text = timeOfDay.format(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Row(
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
              _nameController.text = widget.initialName ?? '';
              _startTimeController.text = widget.initialStartTime ?? '';
              _endTimeController.text = widget.initialEndTime ?? '';
              setState(() {
                _isOvernight = widget.initialIsOvernight;
              });
            },
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.onSubmit(
                  name: _nameController.text,
                  startTime: _startTimeController.text,
                  endTime: _endTimeController.text,
                  isOvernight: _isOvernight,
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }
}
