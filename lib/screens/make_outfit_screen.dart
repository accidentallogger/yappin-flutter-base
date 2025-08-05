import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutterbackgroundremover/backgroundremover.dart';

class MakeOutfitScreen extends StatefulWidget {
  const MakeOutfitScreen({super.key});

  @override
  State<MakeOutfitScreen> createState() => _StyleHubScreenState();
}

class _ApparelData {
  double left;
  double top;
  double scale;
  final String imagePath;

  _ApparelData({
    required this.left,
    required this.top,
    required this.imagePath,
    this.scale = 1.0,
  });
}

class _StyleHubScreenState extends State<MakeOutfitScreen> {
  final Map<int, double> _gestureInitialScales = {};
  int _selectedMode = 0; // 0 = Canvas, 1 = Slider
  int _sliderStyleMode = 0; // 0 = 3 sliders, 1 = 4 sliders, 2 = 2 sliders
  final List<_ApparelData> _canvasItems = [];

  final Map<int, double> _initialScales = {};

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
              _addCanvasItem('assets/placeholders/shirt.png');
            },
          ),
          ListTile(
            leading: const Icon(Icons.checkroom),
            title: const Text('Pants'),
            onTap: () {
              Navigator.pop(context);
              _addCanvasItem('assets/placeholders/pant.png');
            },
          ),
          ListTile(
            leading: const Icon(Icons.checkroom),
            title: const Text('Accessory'),
            onTap: () {
              Navigator.pop(context);
              _addCanvasItem('assets/placeholders/shirt.png');
            },
          ),
          ListTile(
            leading: const Icon(Icons.checkroom),
            title: const Text('Footwear'),
            onTap: () {
              Navigator.pop(context);
              _addCanvasItem('assets/placeholders/shirt.png');
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
        ..._canvasItems.asMap().entries.map((entry) {
          int index = entry.key;
          _ApparelData item = entry.value;

          return Positioned(
            left: item.left,
            top: item.top,
            child: GestureDetector(
              onScaleStart: (_) {
                _gestureInitialScales[index] = item.scale;
              },
              onScaleUpdate: (details) {
                setState(() {
                  item.left = item.left + details.focalPointDelta.dx;
                  item.top =  item.top + details.focalPointDelta.dy;
                  final initial = _gestureInitialScales[index] ?? item.scale;
                  item.scale = (initial * details.scale).clamp(0.5, 2.0);
                  print(item.scale);
                  print(_gestureInitialScales);
                });
              },
              onScaleEnd:(details){
                setState((){
                  _gestureInitialScales[index] = item.scale;
                });
              },
              child: Transform.scale(
                scale: item.scale,
                child: Image.asset(item.imagePath, width: 80, height: 80),
              ),
            ),
          );
        }),
        Positioned(
          bottom: 20,
          right: 20,
          child: FloatingActionButton(
            onPressed: _openImagePicker,
            backgroundColor: const Color(0xFFF75A5A),
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ],
    );
  }

  Widget _sliderRow(List<String> imagePaths) {
    return SizedBox(
      height: 120,
      child: PageView.builder(
        controller: PageController(viewportFraction: 0.45, initialPage: 1000),
        itemBuilder: (context, index) {
          final path = imagePaths[index % imagePaths.length];
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 6.0),
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: const Color(0xFFCCCCCC),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(path, fit: BoxFit.contain),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sliderView() {
    List<Widget> sliders = [];

    if (_sliderStyleMode == 0) {
      sliders = [
        _sliderRow(['assets/placeholders/shirt.png', 'assets/placeholders/shirt.png']),
        _sliderRow(['assets/placeholders/pant.png', 'assets/placeholders/pant.png']),
        _sliderRow(['assets/placeholders/foot.png', 'assets/placeholders/foot.png']),
      ];
    } else if (_sliderStyleMode == 1) {
      sliders = [
        _sliderRow(['assets/placeholders/outer.png', 'assets/placeholders/outer.png']),
        _sliderRow(['assets/placeholders/shirt.png', 'assets/placeholders/shirt.png']),
        _sliderRow(['assets/placeholders/pant.png', 'assets/placeholders/pant.png']),
        _sliderRow(['assets/placeholders/foot.png', 'assets/placeholders/foot.png']),
      ];
    } else {
      sliders = [
        _sliderRow(['assets/placeholders/shirt.png', 'assets/placeholders/shirt.png']),
        _sliderRow(['assets/placeholders/pant.png', 'assets/placeholders/pant.png']),
      ];
    }

    return Column(
      children: [
        const SizedBox(height: 10),
        DropdownButton<int>(
          value: _sliderStyleMode,
          onChanged: (val) => setState(() => _sliderStyleMode = val!),
          items: const [
            DropdownMenuItem(value: 0, child: Text("Upper + Bottom + Footwear")),
            DropdownMenuItem(value: 1, child: Text("Outer + Upper + Bottom + Foot")),
            DropdownMenuItem(value: 2, child: Text("Single + Footwear")),
          ],
        ),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.all(8),
            children: sliders,
          ),
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
          const SizedBox(height: 10),
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

