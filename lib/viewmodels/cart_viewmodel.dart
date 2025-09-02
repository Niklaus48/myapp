
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();
  List<Product> _cartProducts = [];
  StreamSubscription<List<Product>>? _cartSubscription;

  List<Product> get cartProducts => _cartProducts;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CartViewModel() {
    _listenToCart();
  }

  void _listenToCart() {
    _isLoading = true;
    notifyListeners();
    _cartSubscription = _cartService.getCartStream().listen((products) {
      _cartProducts = products;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addToCart(Product product) async {
    await _cartService.addToCart(product);
  }

  Future<void> removeFromCart(Product product) async {
    await _cartService.removeFromCart(product);
  }

  Future<void> increaseQuantity(Product product) async {
    await _cartService.updateQuantity(product, product.quantity + 1);
  }

  Future<void> decreaseQuantity(Product product) async {
    await _cartService.updateQuantity(product, product.quantity - 1);
  }
  
  @override
  void dispose() {
    _cartSubscription?.cancel();
    super.dispose();
  }
}
