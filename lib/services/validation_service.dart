import 'package:dio/dio.dart';
import '../models/validation.dart';

class ValidationService {
  final Dio _dio = Dio(BaseOptions(baseUrl: 'http://localhost:4000/api'));

  Future<List<Validation>> getValidations() async {
    final response = await _dio.get('/validations');
    final data = response.data as List;
    return data.map((json) => Validation.fromJson(json)).toList();
  }

  Future<Validation> updateStatus(int id, String status) async {
    final response = await _dio.patch('/validations/$id', data: {'status': status});
    return Validation.fromJson(response.data['validation']);
  }
}
