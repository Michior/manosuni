import 'package:dio/dio.dart';
import 'validation_model.dart';

class ValidationService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:4000/api'));

  Future<List<Validation>> getValidations() async {
    final response = await _dio.get('/validations');
    return (response.data as List)
        .map((json) => Validation.fromJson(json))
        .toList();
  }

  Future<void> updateStatus(int id, String status) async {
    await _dio.patch('/validations/$id', data: {'status': status});
  }
}
