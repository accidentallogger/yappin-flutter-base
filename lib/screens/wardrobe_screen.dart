import 'package:flutter/material.dart';
import '../api/api_service.dart';
import 'dart:convert';
import '../screens/add_apparel_screen.dart';

class WardrobeScreen extends StatefulWidget {
  const WardrobeScreen({Key? key}) : super(key: key);

  @override
  State<WardrobeScreen> createState() => _WardrobeScreenState();
}

class _WardrobeScreenState extends State<WardrobeScreen> {
  late final ApiService _apiService;
  late Future<List<String>> _wardrobeImages;
  OverlayEntry? _popupOverlay;

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

  void _handleMenuSelection(String choice) {
    _removeOverlay();
    switch (choice) {
      case 'Add Apparel':
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddApparelScreen()),
        );
        break;
      case 'See / Make Outfits':
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Navigate to Outfit Screen")),
        );
        break;
    }
  }

  void _removeOverlay() {
    _popupOverlay?.remove();
    _popupOverlay = null;
  }

  void _showCustomPopupMenu(BuildContext context, Offset offset) {
    _removeOverlay(); // Clean up any existing overlay

    final RenderBox overlay = Overlay.of(context).context.findRenderObject() as RenderBox;
    final Size screenSize = overlay.size;
    final double menuHeight = 120; // estimated

    // Adjust offset to ensure the menu appears fully on screen
    double top = offset.dy - menuHeight;
    if (top < 20) top = 20;

    _popupOverlay = OverlayEntry(
      builder: (context) => GestureDetector(
        onTap: _removeOverlay,
        child: Stack(
          children: [
            Container(
              width: screenSize.width,
              height: screenSize.height,
              color: Colors.black.withOpacity(0.4), // Dimmed background
            ),
            Positioned(
              left: offset.dx - 150, // Adjust as needed to center
              top: top,
              child: Material(
                color: const Color(0xFFEFEFEF),
                elevation: 8,
                borderRadius: BorderRadius.circular(5),
                child: Container(
                  width: 200,
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ListTile(
                        leading: const Icon(Icons.add, color: Colors.black),
                        title: const Text("Add Apparel", style: TextStyle(color: Colors.black)),
                        onTap: () => _handleMenuSelection('Add Apparel'),
                      ),
                      ListTile(
                        leading: const Icon(Icons.style, color: Colors.black),
                        title: const Text("See / Make Outfits", style: TextStyle(color: Colors.black)),
                        onTap: () => _handleMenuSelection('See / Make Outfits'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_popupOverlay!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('My Wardrobe'),
        backgroundColor: const Color(0xFFF75A5A),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const SizedBox(height: 10),
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
          Positioned(
            bottom: 20,
            right: 20,
            child: GestureDetector(
              onTapDown: (details) {
                _showCustomPopupMenu(context, details.globalPosition);
              },
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFFF75A5A), // Better visibility
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 6,
                      offset: const Offset(0, 4),
                    )
                  ],
                ),
                padding: const EdgeInsets.all(16),
                child: const Icon(Icons.menu, color: Colors.white),
              ),
            ),
          ),
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
