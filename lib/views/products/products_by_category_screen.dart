import 'package:flutter/material.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/widgets/product_card.dart';
import 'package:provider/provider.dart';

class ProductsByCategoryScreen extends StatelessWidget {
  final String category;

  const ProductsByCategoryScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final products = productViewModel.products
        .where((product) => product.category == category)
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(category),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.7,
        ),
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return ProductCard(product: product);
        },
      ),
    );
  }
}
