import 'package:flutter/material.dart';

class RecommendScreen extends StatelessWidget {
  const RecommendScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recommended Outfits'),
        backgroundColor: Color(0xFFF75A5A),
      ),
      body: const Center(
        child: Text('AI-based Outfit Suggestions will appear here.'),
      ),
    );
  }
}
