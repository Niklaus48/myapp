import 'package:flutter/material.dart';
import 'package:myapp/models/order.dart';

class OrderViewModel extends ChangeNotifier {
  final List<Order> _orders = [];

  List<Order> get orders => _orders;

  void addOrder(Order order) {
    _orders.add(order);
    notifyListeners();
  }
}
