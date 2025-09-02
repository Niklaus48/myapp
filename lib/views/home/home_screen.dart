import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/widgets/product_card.dart';
import 'package:provider/provider.dart';
import 'package:myapp/views/cart/cart_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const CartScreen()),
              );
            },
          ),
        ],
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: productViewModel.products.length,
        itemBuilder: (context, index) {
          final product = productViewModel.products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
