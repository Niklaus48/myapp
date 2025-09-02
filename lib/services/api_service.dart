import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/product.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<List<Product>> getProducts() async {
    final response = await http.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final List<Product> products = (data['products'] as List)
          .map((item) => Product.fromJson(item))
          .toList();
      return products;
    } else {
      throw Exception('Failed to load products');
    }
  }
}
