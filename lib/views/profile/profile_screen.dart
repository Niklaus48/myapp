import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/auth_viewmodel.dart';
import 'package:myapp/viewmodels/order_viewmodel.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context);
    final orderViewModel = Provider.of<OrderViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authViewModel.logout();
            },
          )
        ],
      ),
      body: authViewModel.isAuthenticated
          ? ListView.builder(
              itemCount: orderViewModel.orders.length,
              itemBuilder: (context, index) {
                final order = orderViewModel.orders[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ExpansionTile(
                    title: Text('Order #${order.id.substring(0, 8)}...'),
                    subtitle: Text(
                        'Total: \$${order.total.toStringAsFixed(2)} - ${DateFormat.yMMMd().format(order.date)}'),
                    children: order.items
                        .map((item) => ListTile(
                              leading: Image.network(item.product.thumbnail),
                              title: Text(item.product.title),
                              subtitle: Text(
                                  '\$${item.product.price.toStringAsFixed(2)} x ${item.quantity}'),
                            ))
                        .toList(),
                  ),
                );
              },
            )
          : Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Please log in to see your profile.'),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LoginScreen(),
                        ),
                      );
                    },
                    child: const Text('Login'),
                  ),
                ],
              ),
            ),
    );
  }
}

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authViewModel = Provider.of<AuthViewModel>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            authViewModel.login();
            Navigator.pop(context);
          },
          child: const Text('Login'),
        ),
      ),
    );
  }
}
