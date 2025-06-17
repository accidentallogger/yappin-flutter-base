// screens/wardrobe_screen.dart

import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'dart:convert';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({Key? key}) : super(key: key);

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  late final ApiService _apiService;


  late Future<List<String>> _wardrobeImages;
  @override
  void initState() {
    super.initState();
    _apiService = ApiService();
    _wardrobeImages = _apiService.fetchWardrobeImages();
  }

  Widget buildImage(String base64String) {
    return Container(
      margin: const EdgeInsets.all(8),
      child: Image.memory(
        base64Decode(base64String),
        width: 180,
        height: 180,
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Wardrobe'),
        backgroundColor: const Color(0xFF91A892),
      ),
      body: Column(
        children: [
          const SizedBox(height: 10),
          // Category buttons (All, Upper, Lower, Other)
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 10),
              children: const [
                WardrobeCategoryButton(label: 'All'),
                WardrobeCategoryButton(label: 'Upper'),
                WardrobeCategoryButton(label: 'Lower'),
                WardrobeCategoryButton(label: 'Other'),
              ],
            ),
          ),
          const SizedBox(height: 10),
          // Wardrobe Images
          Expanded(
            child: FutureBuilder<List<String>>(
              future: _wardrobeImages,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text("Error: ${snapshot.error}"));
                } else {
                  final images = snapshot.data!;
                  return ListView(
                    scrollDirection: Axis.horizontal,
                    children: images.map(buildImage).toList(),
                  );
                }
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF91A892),
        selectedItemColor: Colors.black,
        unselectedItemColor: Colors.black54,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: 'Wardrobe'),
          BottomNavigationBarItem(icon: Icon(Icons.work), label: 'Work'),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: 'Style'),
        ],
      ),
    );
  }
}

class WardrobeCategoryButton extends StatelessWidget {
  final String label;

  const WardrobeCategoryButton({super.key, required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          // TODO: Add filter logic
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: const Color(0xFFEFEFEF),
          foregroundColor: Colors.black,
        ),
        child: Text(label),
      ),
    );
  }
}
