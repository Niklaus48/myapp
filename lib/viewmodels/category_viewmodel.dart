
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/services/api_service.dart';

class CategoryViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Category> _categories = [];
  bool _isLoading = false;
  String? _error;

  List<Category> get categories => _categories;
  bool get isLoading => _isLoading;
  String? get error => _error;

  Future<void> fetchCategories() async {
    try {
      _isLoading = true;
      _error = null;
      notifyListeners();

      final List<dynamic> data = await _apiService.get('products/categories');
      _categories = data
          .map((category) => Category.fromJson(category.toString()))
          .toList();
    } catch (e) {
      _error = 'Failed to load categories: ${e.toString()}';
      debugPrint(_error);
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
