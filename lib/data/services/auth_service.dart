import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  final String baseUrl = "http://helix.runasp.net";

  Future<Map<String, dynamic>> login(String email, String password) async {
    final url = Uri.parse("$baseUrl/api/Auth/Login");

    try {
      print("Attemping login to: $url");
      print("Body: ${jsonEncode({'emailAddress': email, 'password': password})}");

      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
          'Accept': '*/*', // مهم جداً عشان السيرفر يرضى يرد علينا
        },
        body: jsonEncode({
          // التعديل الهام جداً بناءً على صورة Swagger
          'emailAddress': email, 
          'password': password,
        }),
      );

      print("Response Status: ${response.statusCode}");
      print("Response Body: ${response.body}");

      // تحويل النص لـ JSON
      final responseData = jsonDecode(response.body);

      // التحقق من النجاح بناءً على هيكل البيانات في الصورة
      if (response.statusCode == 200 && responseData['succeeded'] == true) {
        // نجاح! بنرجع البيانات كاملة
        return responseData;
      } else {
        // فشل! بنعرض الرسالة اللي جاية من السيرفر (message)
        throw Exception(responseData['message'] ?? 'Login failed');
      }
    } catch (e) {
      // لو فيه مشكلة في النت
      throw Exception('Connection Error: $e');
    }
  }
}