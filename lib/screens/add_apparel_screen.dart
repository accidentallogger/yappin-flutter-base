import 'package:flutter/material.dart';

class AddApparelScreen extends StatelessWidget {
  const AddApparelScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Apparel'),
        backgroundColor: Color(0xFFFFCC33),
      ),
      body: const Center(
        child: Text('Form to Add Apparel (image, category, type, color, etc.)'),
      ),
    );
  }
}
