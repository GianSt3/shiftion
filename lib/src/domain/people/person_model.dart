import '../../data/entities/person_entity.dart';

class PersonModel {
  final int? id;

  final String name;
  final bool isEmployee;
  final bool isFreelance;
  final bool isIntern;

  PersonModel({
    required this.name,
    required this.isEmployee,
    this.id,
    this.isFreelance = false,
    this.isIntern = false,
  });

  @override
  String toString() {
    return 'PersonModel{id: $id, name: $name, isEmployee: $isEmployee, isFreelance: $isFreelance, isIntern: $isIntern}';
  }

  factory PersonModel.fromEntity(PersonEntity entity) {
    return PersonModel(
      id: entity.id,
      name: entity.name,
      isEmployee: entity.isEmployee,
      isFreelance: entity.isFreelance,
      isIntern: entity.isIntern,
    );
  }

  String get roleText {
    if (isEmployee) return 'Employee';
    if (isFreelance) return 'Freelance';
    if (isIntern) return 'Intern';
    return '';
  }
}

// person_model.dart
extension PersonModelConverter on PersonModel {
  PersonEntity toEntity() {
    return PersonEntity(
      id: id,
      name: name,
      isEmployee: isEmployee,
      isFreelance: isFreelance,
      isIntern: isIntern,
    );
  }
}

enum PersonRole { employee, freelance, intern }
