import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/cart_view_model.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: ListView.builder(
        itemCount: cartViewModel.cart.length,
        itemBuilder: (context, index) {
          final product = cartViewModel.cart[index];
          return ListTile(
            leading: Image.network(product.thumbnail),
            title: Text(product.title),
            subtitle: Text('\$${product.price.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: const Icon(Icons.remove_shopping_cart),
              onPressed: () {
                cartViewModel.removeFromCart(product);
              },
            ),
          );
        },
      ),
    );
  }
}
