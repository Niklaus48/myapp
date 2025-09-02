
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/api_service.dart';

class ProductViewModel extends ChangeNotifier {
  final ApiService _apiService = ApiService();

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  bool _isLoading = false;

  // Filter states
  String _searchQuery = '';
  String? _selectedCategory;
  double _maxPrice = 2000;
  RangeValues _priceRange = const RangeValues(0, 2000);

  // Pagination states
  static const int itemsPerPage = 30;
  int _currentPage = 1;
  int _totalPages = 1;

  bool get isLoading => _isLoading;

  List<Product> get products => _getPagedProducts();
  List<Product> get allProducts => _filteredProducts;
  RangeValues get priceRange => _priceRange;
  double get maxPrice => _maxPrice;
  String? get selectedCategory => _selectedCategory;
  int get currentPage => _currentPage;
  int get totalPages => _totalPages;

  List<Product> _getPagedProducts() {
    final startIndex = (_currentPage - 1) * itemsPerPage;
    final endIndex = startIndex + itemsPerPage;
    if (startIndex >= _filteredProducts.length) return [];
    return _filteredProducts.sublist(
      startIndex,
      endIndex > _filteredProducts.length ? _filteredProducts.length : endIndex,
    );
  }

  void nextPage() {
    if (_currentPage < _totalPages) {
      _currentPage++;
      notifyListeners();
    }
  }

  void previousPage() {
    if (_currentPage > 1) {
      _currentPage--;
      notifyListeners();
    }
  }

  void goToPage(int page) {
    if (page >= 1 && page <= _totalPages) {
      _currentPage = page;
      notifyListeners();
    }
  }

  Future<void> fetchProducts({String? category}) async {
    try {
      _isLoading = true;
      notifyListeners();

      String endpoint = 'products';
      if (category != null) {
        endpoint = 'products/category/$category';
      }

      // First, get total count
      final initialData = await _apiService.get(endpoint, queryParams: {
        'limit': 1,
        'skip': 0,
      });

      final totalProducts = initialData['total'] ?? 0;
      _allProducts = [];

      // Fetch all products in chunks
      for (var skip = 0; skip < totalProducts; skip += 100) {
        final data = await _apiService.get(endpoint, queryParams: {
          'limit': 100,
          'skip': skip,
        });
        
        final products = (data['products'] as List)
            .map((json) => Product.fromJson(json))
            .toList();
            
        _allProducts.addAll(products);
      }

      if (_allProducts.isNotEmpty) {
        _maxPrice = _allProducts
            .map((p) => p.price.toDouble())
            .reduce((a, b) => a > b ? a : b);
        _priceRange = RangeValues(0, _maxPrice);
      }

      _applyFilters();
    } catch (e) {
      debugPrint('Error fetching products: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  void _applyFilters() {
    _filteredProducts = _allProducts.where((product) {
      final categoryMatch = _selectedCategory == null ||
          _selectedCategory!.isEmpty ||
          product.category == _selectedCategory;

      final searchMatch = _searchQuery.isEmpty ||
          product.title.toLowerCase().contains(_searchQuery.toLowerCase());

      final priceMatch =
          product.price >= _priceRange.start && product.price <= _priceRange.end;

      return categoryMatch && searchMatch && priceMatch;
    }).toList();

    _totalPages = (_filteredProducts.length / itemsPerPage).ceil();
    _currentPage = 1; // Reset to first page when filters change
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    _searchQuery = query;
    _applyFilters();
  }

  Future<void> updateCategory(String? category) async {
    _selectedCategory = category;
    await fetchProducts(category: category);
    _applyFilters();
  }

  void updatePriceRange(RangeValues range) {
    _priceRange = range;
    _applyFilters();
  }

  void clearFilters() {
    _searchQuery = '';
    _selectedCategory = null;
    _priceRange = RangeValues(0, _maxPrice);
    _applyFilters();
  }
}
