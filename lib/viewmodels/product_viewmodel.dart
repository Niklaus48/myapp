
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];

  List<Product> get products => _products;

  Future<void> fetchProducts() async {
    try {
      final data = await _apiService.get('products');
      _products = (data['products'] as List)
          .map((json) => Product.fromJson(json))
          .toList();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
