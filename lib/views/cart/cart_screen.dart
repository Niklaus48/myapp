import 'package:flutter/material.dart';
import 'package:myapp/models/order.dart';
import 'package:myapp/viewmodels/auth_viewmodel.dart';
import 'package:myapp/viewmodels/cart_viewmodel.dart';
import 'package:myapp/viewmodels/order_viewmodel.dart';
import 'package:myapp/views/profile/profile_screen.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartViewModel = Provider.of<CartViewModel>(context);
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    final orderViewModel = Provider.of<OrderViewModel>(context, listen: false);
    const uuid = Uuid();

    void checkout() {
      if (authViewModel.isAuthenticated) {
        final newOrder = Order(
          id: uuid.v4(),
          items: List.from(cartViewModel.cartItems),
          total: cartViewModel.totalPrice,
          date: DateTime.now(),
        );
        orderViewModel.addOrder(newOrder);
        cartViewModel.clearCart();
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Checkout Successful'),
            content: const Text('Your order has been placed.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const LoginScreen(),
          ),
        );
      }
    }

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
          return Dismissible(
            key: Key(cartItem.product.id.toString()),
            onDismissed: (direction) {
              cartViewModel.removeFromCart(cartItem);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${cartItem.product.title} removed from cart'),
                ),
              );
            },
            background: Container(
              color: Colors.red,
              alignment: Alignment.centerRight,
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: const Icon(Icons.delete, color: Colors.white),
            ),
            child: ListTile(
              leading: Image.network(cartItem.product.thumbnail),
              title: Text(cartItem.product.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cartItem.product.category),
                  Text(
                      '\$${cartItem.product.price.toStringAsFixed(2)} x ${cartItem.quantity}'),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.remove),
                    onPressed: () => cartViewModel.decreaseQuantity(cartItem),
                  ),
                  Text(cartItem.quantity.toString()),
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => cartViewModel.increaseQuantity(cartItem),
                  ),
                ],
              ),
            ),
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
              onPressed: checkout,
              child: const Text('Checkout'),
            ),
          ],
        ),
      ),
    );
  }
}
