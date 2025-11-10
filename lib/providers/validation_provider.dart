import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/validation.dart';
import '../services/validation_service.dart';

final validationServiceProvider = Provider((ref) => ValidationService());

final validationsProvider = FutureProvider<List<Validation>>((ref) async {
  final service = ref.read(validationServiceProvider);
  return service.getValidations();
});
