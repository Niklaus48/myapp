import 'package:flutter/material.dart';
import 'package:myapp/views/auth/auth_wrapper.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: AuthWrapper(),
    );
  }
}
