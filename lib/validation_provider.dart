import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'validation_model.dart';
import 'validation_service.dart';

final validationServiceProvider = Provider((ref) => ValidationService());

final validationsProvider = FutureProvider<List<Validation>>((ref) async {
  final service = ref.watch(validationServiceProvider);
  return service.getValidations();
});
