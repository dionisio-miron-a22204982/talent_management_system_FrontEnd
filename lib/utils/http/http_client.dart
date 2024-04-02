import 'dart:convert';
import 'package:http/http.dart' as http;

class TFCHttpHelper {
  static const String _baseUrl = 'http:notDone';

  //  Helper for Get and Post
  static Future<Map<String, dynamic>> get(String endpoint) async {
    final response = await http.get(Uri.parse('$_baseUrl/$endpoint'));
    return _handleResponse(response);
  }

  static Future<Map<String, dynamic>> post(String endpoint, dynamic data) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/$endpoint'),
      headers:{'Content-Type' : 'application/json'},
      body: json.encode(data),
    );
    return _handleResponse(response);
  }

  // Handle Response
  static Map<String, dynamic> _handleResponse(http.Response response) {
    if (response.statusCode == 200) { // 200 = 'OK'
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data: ${response.statusCode}');
    }
  }
}