import 'package:flutter/material.dart';
import 'screens/wardrobe_screen.dart';
import 'screens/add_apparel_screen.dart';
import 'screens/make_outfit_screen.dart';
import 'screens/recommend_screen.dart';

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
    const RecommendScreen(),
  ];

  void _onBottomNavTap(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 80,
        elevation: 4,
        title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.person_outline, size: 30, color: Colors.black),
              Image.asset('assets/icons/yapp_logo.png', height: 35),
            ],
          ),
        ),
      ),
      body: _screens[_selectedIndex],
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.teal.shade400,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddApparelScreen()),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text("Add Apparel"),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: _onBottomNavTap,
          selectedItemColor: Colors.teal.shade700,
          unselectedItemColor: Colors.grey,
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.checkroom), label: "Wardrobe"),
            BottomNavigationBarItem(icon: Icon(Icons.create), label: "Make Outfit"),
            BottomNavigationBarItem(icon: Icon(Icons.style), label: "Recommend"),
          ],
        ),
      ),
    );
  }
}

class HomeDashboard extends StatelessWidget {
  const HomeDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: GridView.count(
        crossAxisCount: 2,
        childAspectRatio: 4 / 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          _HomeCard(
            title: "View Wardrobe",
            icon: Icons.checkroom,
            color: Colors.teal.shade100,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WardrobeScreen()),
            ),
          ),
          _HomeCard(
            title: "New Outfit",
            icon: Icons.add_circle_outline,
            color: Colors.orange.shade100,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MakeOutfitScreen()),
            ),
          ),
          _HomeCard(
            title: "Recommendations",
            icon: Icons.lightbulb_outline,
            color: Colors.purple.shade100,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const RecommendScreen()),
            ),
          ),
        ],
      ),
    );
  }
}

class _HomeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const _HomeCard({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 2,
      borderRadius: BorderRadius.circular(16),
      color: color,
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, size: 40),
              const Spacer(),
              Text(
                title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
