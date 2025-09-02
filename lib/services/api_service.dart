import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:myapp/models/product.dart';

class ApiService {
  static const String baseUrl = 'https://dummyjson.com';

  Future<dynamic> get(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data from $endpoint');
    }
  }

  Future<List<Product>> getProducts() async {
    final data = await get('products');
    final List<Product> products = (data['products'] as List)
        .map((item) => Product.fromJson(item))
        .toList();
    return products;
  }
}
