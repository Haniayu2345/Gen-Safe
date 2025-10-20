import 'package:flutter/material.dart';

class GenFrenScreen extends StatelessWidget {
  const GenFrenScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Gen-Fren'),
        backgroundColor: const Color.fromARGB(255, 220, 214, 220),
      ),
      body: const Center(
        child: Text(
          'Hai, ini Gen-Fren!',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
