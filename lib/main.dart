import 'package:flutter/material.dart';
import 'package:myapp/theme/app_theme.dart';
import 'package:myapp/viewmodels/cart_view_model.dart';
import 'package:myapp/viewmodels/product_viewmodel.dart';
import 'package:myapp/views/home/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ProductViewModel()),
        ChangeNotifierProvider(create: (_) => CartViewModel()),
      ],
      child: MaterialApp(
        title: 'E-commerce App',
        theme: AppTheme.lightTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
