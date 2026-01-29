import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "https://helix.runasp.net"; 

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/api/Auth/Login");

    try {
      print("Attemping login to: $url");
      // طباعة الـ Body للتأكد من البيانات المرسلة
      print("Body: ${jsonEncode({'emailAddress': email, 'password': password})}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*', 
        },
        body: jsonEncode({
          'emailAddress': email, 
          'password': password,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      final responseData = jsonDecode(response.body);

      if (response.statusCode == 200 && responseData['succeeded'] == true) {
        return responseData;
      } else {
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      throw Exception('Connection Error: $e');
    }
  }
}