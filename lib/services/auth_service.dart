import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // Cambia esta URL por la de tu backend (usa http://10.0.2.2:3000 para emulador Android si corres localmente)
  final String baseUrl = 'https://9e3ab28e411b.ngrok-free.app/api/auth';

  Future<Map<String, dynamic>> _post(String path, Map<String, dynamic> body, int expectedStatusCode) async {
    final uri = Uri.parse('$baseUrl$path');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(body),
    );

    final responseBody = response.body;
    if (response.statusCode == expectedStatusCode) {
      final decoded = jsonDecode(responseBody);
      return decoded is Map<String, dynamic> ? decoded : {'result': decoded};
    } else {
      throw Exception('Error ${response.statusCode}: $responseBody');
    }
  }

  Future<Map<String, dynamic>> register(String email, String password, String role, String trim) async {
    return await _post('/register', {'email': email, 'password': password, 'role': role}, 201);
  }

  Future<Map<String, dynamic>> login(String email, String password) async {
    return await _post('/login', {'email': email, 'password': password}, 200);
  }
}
