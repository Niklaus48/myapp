
import 'package:flutter/material.dart';
import 'package:myapp/models/product.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/views/products/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  _ProductListScreenState createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  @override
  void initState() {
    super.initState();
    Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);

    return Scaffold(
      appBar: AppBar(title: const Text(\'Products\')),\n      body: ListView.builder(\n        itemCount: productViewModel.products.length,\n        itemBuilder: (context, index) {\n          final product = productViewModel.products[index];\n          return ListTile(\n            leading: Image.network(product.thumbnail),\n            title: Text(product.title),\n            subtitle: Text(\'\\\$${product.price}\'),\n            onTap: () {\n              Navigator.push(\n                context,\n                MaterialPageRoute(\n                  builder: (context) => ProductDetailScreen(product: product),\n                ),\n              );\n            },\n          );\n        },\n      ),\n    );\n  }\n}\n