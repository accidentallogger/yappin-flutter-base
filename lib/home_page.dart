import 'package:flutter/material.dart';
import 'screens/wardrobe_screen.dart';
import 'screens/make_outfit_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeDashboard(),
    const WardrobeScreen(),
    const MakeOutfitScreen(),
    Center(child: Text("Recommend Screen")), // placeholder
  ];

  void _onBottomNavTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onBottomNavTap,
        selectedItemColor: const Color(0xFFF75A5A),
        unselectedItemColor: Colors.grey,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: "Wardrobe"),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: "StyleHub"),
          BottomNavigationBarItem(icon: Icon(Icons.style), label: "Recommend"),
        ],
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Home Dashboard',
        style: TextStyle(fontSize: 24),
      ),
    );
  }
}
