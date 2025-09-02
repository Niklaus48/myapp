
import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'https://dummyjson.com';

  Future<dynamic> get(String endpoint, {Map<String, dynamic>? queryParams}) async {
    final uri = Uri.parse('$_baseUrl/$endpoint').replace(
      queryParameters: queryParams?.map((key, value) => MapEntry(key, value.toString())),
    );
    
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }
}
