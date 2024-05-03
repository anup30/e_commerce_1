import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('e-commerce project - Crafty Bay'),
        backgroundColor: Colors.blue,
      ),
      body: const Center(
        child: Text('Hello'),
      ),
    );
  }
}