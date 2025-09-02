
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:myapp/models/cart_item.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/services/cart_service.dart';

class CartViewModel extends ChangeNotifier {
  final CartService _cartService = CartService();
  List<CartItem> _cartItems = [];
  StreamSubscription<List<CartItem>>? _cartSubscription;

  List<CartItem> get cartItems => _cartItems;
  bool _isLoading = false;
  bool get isLoading => _isLoading;

  CartViewModel() {
    _listenToCart();
  }

  void _listenToCart() {
    _isLoading = true;
    notifyListeners();
    _cartSubscription = _cartService.getCartStream().listen((items) {
      _cartItems = items;
      _isLoading = false;
      notifyListeners();
    });
  }

  Future<void> addToCart(Product product) async {
    await _cartService.addToCart(product);
  }

  Future<void> removeFromCart(CartItem item) async {
    await _cartService.removeFromCart(item.product);
  }

  Future<void> increaseQuantity(CartItem item) async {
    await _cartService.updateQuantity(item.product, item.quantity + 1);
  }

  Future<void> decreaseQuantity(CartItem item) async {
    if (item.quantity > 1) {
      await _cartService.updateQuantity(item.product, item.quantity - 1);
    } else {
      await removeFromCart(item);
    }
  }
  
  @override
  void dispose() {
    _cartSubscription?.cancel();
    super.dispose();
  }
}
