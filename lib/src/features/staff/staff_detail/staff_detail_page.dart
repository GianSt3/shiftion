import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/staff_detail_cubit.dart';

class StaffDetailPage extends StatelessWidget {
  const StaffDetailPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StaffDetailCubit, StaffDetailState>(
      builder: (context, state) {
        return switch (state) {
          StaffDetailInitial() =>
            const Center(child: CircularProgressIndicator()),
          StaffDetailLoading() =>
            const Center(child: CircularProgressIndicator()),
          StaffDetailError(message: final message) =>
            Center(child: Text(message)),
          StaffDetailLoaded(person: final person) => Scaffold(
              appBar: AppBar(title: Text(person.name)),
              body: Center(
                child: Text('Detail'),
              ),
            ),
        };
      },
    );
  }
}
