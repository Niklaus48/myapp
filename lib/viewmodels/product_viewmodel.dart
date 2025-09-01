
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts({String query = '', String? category}) async {
    try {
      String endpoint = 'products';
      if (category != null && category.isNotEmpty) {
        endpoint = 'products/category/$category';
      } else if (query.isNotEmpty) {
        endpoint = 'products/search?q=$query';
      }

      final data = await _apiService.get(endpoint);
      _products = (data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
