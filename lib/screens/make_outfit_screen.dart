import 'package:flutter/material.dart';

class MakeOutfitScreen extends StatefulWidget {
  const MakeOutfitScreen({super.key});

  @override
  State<MakeOutfitScreen> createState() => _StyleHubScreenState();
}

class _ApparelData {
  double left;
  double top;
  final String imagePath;
  _ApparelData({required this.left, required this.top, required this.imagePath});
}

class _StyleHubScreenState extends State<MakeOutfitScreen> {
  int _selectedMode = 0; // 0 = Canvas, 1 = Slider
  final List<_ApparelData> _canvasItems = [];

  void _addCanvasItem(String imagePath) {
    setState(() {
      _canvasItems.add(_ApparelData(left: 100, top: 100, imagePath: imagePath));
    });
  }

  void _openImagePicker() {
    showModalBottomSheet(
      context: context,
      builder: (_) => Wrap(
        children: [
          ListTile(
            leading: const Icon(Icons.checkroom),
            title: const Text('Shirt'),
            onTap: () {
              Navigator.pop(context);
              _addCanvasItem('assets/shirts/shirt1.png');
            },
          ),
          ListTile(
            leading: const Icon(Icons.checkroom),
            title: const Text('Pants'),
            onTap: () {
              Navigator.pop(context);
              _addCanvasItem('assets/pants/pants1.png');
            },
          ),

        ],
      ),
    );
  }

  Widget _canvasView() {
    return Stack(
      children: [
        Container(color: Colors.grey.shade100),
        ..._canvasItems.map((item) => Positioned(
          left: item.left,
          top: item.top,
          child: Draggable(
            feedback: Image.asset(item.imagePath, width: 80, height: 80),
            childWhenDragging: const SizedBox(),
            onDraggableCanceled: (velocity, offset) {
              setState(() {
                item.left = offset.dx;
                item.top = offset.dy - AppBar().preferredSize.height;
              });
            },
            child: Image.asset(item.imagePath, width: 80, height: 80),
          ),
        )),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _openImagePicker,
            backgroundColor: const Color(0xFFF75A5A),
            child: const Icon(Icons.add,color:Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _scrollRow(List<String> imagePaths) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: imagePaths.map((path) {
          return Container(
            margin: const EdgeInsets.symmetric(horizontal: 40),
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: const Color(0xFFCCCCCC),
            ),
            child: Image.asset(path, fit: BoxFit.cover),
          );
        }).toList(),
      ),
    );
  }

  Widget _sliderView() {
    return ListView(
      children: [
        ToggleButtons(
          isSelected: [_selectedMode == 0, _selectedMode == 1],
          onPressed: (index) => setState(() => _selectedMode = index),
          borderRadius: BorderRadius.circular(8),
          selectedColor: Colors.white,
          fillColor: const Color(0xFFF75A5A),
          children: const [
            Padding(padding: EdgeInsets.all(8), child: Text("Canvas")),
            Padding(padding: EdgeInsets.all(8), child: Text("Slider")),
          ],
        ),
        Expanded(
          child: _selectedMode == 0 ? _canvasView() : _sliderView(),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('StyleHub'),
        backgroundColor: const Color(0xFFF75A5A),
      ),
      body: Column(
        children: [
          ToggleButtons(
            isSelected: [_selectedMode == 0, _selectedMode == 1],
            onPressed: (index) => setState(() => _selectedMode = index),
            borderRadius: BorderRadius.circular(8),
            selectedColor: Colors.white,
            fillColor: const Color(0xFFF75A5A),
            children: const [
              Padding(padding: EdgeInsets.all(8), child: Text("Canvas")),
              Padding(padding: EdgeInsets.all(8), child: Text("Slider")),
            ],
          ),
          Expanded(
            child: _selectedMode == 0 ? _canvasView() : _sliderView(),
          ),
        ],
      ),
    );
  }
}
