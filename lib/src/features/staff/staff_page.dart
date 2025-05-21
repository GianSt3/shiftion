import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../l10n/app_localizations.dart';
import '../../core/di/injection.dart';
import '../../data/person_dao.dart';
import '../../domain/people/person_model.dart';
import 'bloc/staff_cubit.dart';
import 'staff_detail/bloc/staff_detail_cubit.dart';
import 'staff_detail/staff_detail_page.dart';

class StaffPage extends StatefulWidget {
  const StaffPage({
    super.key,
  });

  @override
  State<StaffPage> createState() => _StaffPageState();
}

class _StaffPageState extends State<StaffPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  PersonRole _selectedRole = PersonRole.employee;

  @override
  void initState() {
    super.initState();
    context.read<StaffCubit>().loadPeople();
  }

  @override
  void dispose() {
    _nameController.dispose();
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
            AppLocalizations.of(context)!.staff,
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 16),
          Form(
            key: _formKey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 400,
                  child: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: const OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Nome obbligatorio";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: [
                    SizedBox(
                      width: 200,
                      child: RadioListTile<PersonRole>(
                        title: const Text('Employee'),
                        value: PersonRole.employee,
                        groupValue: _selectedRole,
                        onChanged: (PersonRole? value) {
                          setState(() => _selectedRole = value!);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: RadioListTile<PersonRole>(
                        title: const Text('Freelance'),
                        value: PersonRole.freelance,
                        groupValue: _selectedRole,
                        onChanged: (PersonRole? value) {
                          setState(() => _selectedRole = value!);
                        },
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: RadioListTile<PersonRole>(
                        title: const Text('Intern'),
                        value: PersonRole.intern,
                        groupValue: _selectedRole,
                        onChanged: (PersonRole? value) {
                          setState(() => _selectedRole = value!);
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      final person = PersonModel(
                        name: _nameController.text,
                        isEmployee: _selectedRole == PersonRole.employee,
                        isFreelance: _selectedRole == PersonRole.freelance,
                        isIntern: _selectedRole == PersonRole.intern,
                      );

                      context.read<StaffCubit>().addPerson(person);
                      _nameController.clear();
                    }
                  },
                  child: Text("Aggiungi"),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          Divider(),
          Expanded(
            child: BlocBuilder<StaffCubit, StaffState>(
              builder: (context, state) {
                return switch (state) {
                  StaffLoading() => const Center(
                      child: CircularProgressIndicator(),
                    ),
                  StaffLoaded(:final people) => ListView.builder(
                      itemCount: people.length,
                      itemBuilder: (context, index) {
                        final person = people[index];
                        return ListTile(
                          title: Text(person.name),
                          subtitle: Text(person.roleText),
                          onTap: () {
                            /// Open Staff detail
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => StaffDetailCubit(
                                    personDao: getIt<PersonDao>(),
                                  )..fetchPerson(person.id!),
                                  child: StaffDetailPage(),
                                ),
                              ),
                            );
                          },
                          trailing: IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              context.read<StaffCubit>().deletePerson(person);
                            },
                          ),
                        );
                      },
                    ),
                  StaffError(:final message) => Center(
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
