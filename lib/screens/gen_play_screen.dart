import 'package:flutter/material.dart';

class GenPlayScreen extends StatelessWidget {
  const GenPlayScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gen-Play'),
        backgroundColor: const Color.fromARGB(255, 220, 214, 220),
      ),
      body: const Center(
        child: Text(
          'Selamat datang di Gen-Play!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
