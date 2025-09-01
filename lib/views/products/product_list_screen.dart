
import 'package:flutter/material.dart';
import 'package:myapp/models/category.dart';
import 'package:myapp/viewmodels/category_viewmodel.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/views/auth/auth_wrapper.dart';
import 'package:myapp/views/cart/cart_screen.dart';
import 'package:myapp/views/products/product_detail_screen.dart';
import 'package:provider/provider.dart';

class ProductListScreen extends StatefulWidget {
  const ProductListScreen({super.key});

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductViewModel>(context, listen: false).fetchProducts();
    Provider.of<CategoryViewModel>(context, listen: false).fetchCategories();
    _searchController.addListener(() {
      Provider.of<ProductViewModel>(context, listen: false).fetchProducts(
        query: _searchController.text,
        category: _selectedCategory,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final productViewModel = Provider.of<ProductViewModel>(context);
    final categoryViewModel = Provider.of<CategoryViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
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
          IconButton(
            icon: const Icon(Icons.login),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AuthWrapper()),
              );
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(112.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: _searchController,
                  decoration: const InputDecoration(
                    hintText: 'Search products...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: DropdownButton<String>(
                  value: _selectedCategory,
                  hint: const Text('Select a category'),
                  isExpanded: true,
                  items: categoryViewModel.categories
                      .map((Category category) => DropdownMenuItem<String>(
                            value: category.name,
                            child: Text(category.name),
                          ))
                      .toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                    Provider.of<ProductViewModel>(context, listen: false)
                        .fetchProducts(
                      query: _searchController.text,
                      category: _selectedCategory,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: productViewModel.products.length,
        itemBuilder: (context, index) {
          final product = productViewModel.products[index];
          return ListTile(
            leading: Image.network(product.thumbnail),
            title: Text(product.title),
            subtitle: Text('\$${product.price}'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ProductDetailScreen(product: product),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
