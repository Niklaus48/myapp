import 'package:flutter/foundation.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Product> _products = [];

  List<Product> get products => _products;

  ProductViewModel() {
    fetchProducts();
  }

  Future<void> fetchProducts() async {
    try {
      _products = await _apiService.getProducts();
      notifyListeners();
    } catch (e) {
      // Handle error
    }
  }
}
