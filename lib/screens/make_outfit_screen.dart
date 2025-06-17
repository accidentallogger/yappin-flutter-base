import 'package:flutter/material.dart';

class MakeOutfitScreen extends StatefulWidget {
  const MakeOutfitScreen({super.key});

  @override
  State<MakeOutfitScreen> createState() => _MakeOutfitScreenState();
}

class _MakeOutfitScreenState extends State<MakeOutfitScreen> {
  final List<Widget> _apparelWidgets = [];

  void _addApparel() {
    setState(() {
      _apparelWidgets.add(
        Positioned(
          top: 100,
          left: 100,
          child: Draggable(
            feedback: _apparelItem(),
            childWhenDragging: const SizedBox.shrink(),
            child: _apparelItem(),
          ),
        ),
      );
    });
  }

  Widget _apparelItem() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.black),
        image: const DecorationImage(
          image: AssetImage('assets/placeholders/shirt.png'), // Placeholder image
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Make Outfit'),
        backgroundColor: Colors.teal,
      ),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.grey.shade100,
          ),
          ..._apparelWidgets,
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addApparel,
        child: const Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }
}
