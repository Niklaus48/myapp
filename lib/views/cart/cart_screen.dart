
import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/cart_viewmodel.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping Cart'),
        actions: [
          IconButton(
            icon: const Icon(Icons.remove_shopping_cart),
            onPressed: () {
              cartViewModel.clearCart();
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: cartViewModel.cartItems.length,
        itemBuilder: (context, index) {
          final cartItem = cartViewModel.cartItems[index];
          return ListTile(
            leading: Image.network(cartItem.product.thumbnail),
            title: Text(cartItem.product.title),
            subtitle: Text('Quantity: ${cartItem.quantity}'),
            trailing: Text('\$${cartItem.product.price * cartItem.quantity}'),
          );
        },
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$${cartViewModel.totalPrice.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
