// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Italian (`it`).
class AppLocalizationsIt extends AppLocalizations {
  AppLocalizationsIt([String locale = 'it']) : super(locale);

  @override
  String get helloWorld => 'Ciao Mondo!';

  @override
  String get appTitle => 'My App';

  @override
  String get dashboard => 'Dashboard';

  @override
  String get staff => 'Staff';

  @override
  String get schedule => 'Schedule';

  @override
  String people_employee(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count employees',
      one: '1 employee',
      zero: 'No employees',
    );
    return '$_temp0';
  }

  @override
  String people_intern(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count interns',
      one: '1 intern',
      zero: 'No interns',
    );
    return '$_temp0';
  }

  @override
  String people_freelancer(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count freelancers',
      one: '1 freelancer',
      zero: 'No freelancers',
    );
    return '$_temp0';
  }
}
