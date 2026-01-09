import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'home_page.dart';
import 'fnb_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  void _changeTab(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // List Halaman (Initialized here to access _changeTab)
    final List<Widget> pages = [
      HomePage(key: const ValueKey('Home'), onTabChange: _changeTab),
      const Center(
        key: ValueKey('Ticket'),
        child: Text("Halaman Ticket", style: TextStyle(fontSize: 24)),
      ),
      const FnbPage(key: ValueKey('FnB')),
      ProfilePage(key: const ValueKey('Profile'), onTabChange: _changeTab),
    ];

    return Scaffold(
      backgroundColor: Colors.white, // FIX: Changed to white to match design
      body: Stack(
        children: [
          // Page Content
          Positioned.fill(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: pages[_selectedIndex],
            ),
          ),

          // Bottom Navigation Bar (Anchored)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildBottomNavBar(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomNavBar(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double itemWidth = screenWidth / 4;

    return SizedBox(
      height: 90, // Total height including floating icon
      child: Stack(
        alignment: Alignment.bottomCenter,
        clipBehavior: Clip.none, // Allow icon to overflow upward
        children: [
          // ===== 1. RED BAR (Full Width, Rounded Top) =====
          Container(
            height: 70,
            width: double.infinity, // CRITICAL: Full width
            decoration: BoxDecoration(
              color: const Color(0xFFFF3D3D),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(24), // Smooth rounded corners
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
          ),

          // ===== 2. FLOATING ICON (Active Tab Indicator) =====
          AnimatedPositioned(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
            left: (_selectedIndex * itemWidth) + (itemWidth / 2) - 28,
            bottom: 40, // Positions icon to overlap the top edge
            child: Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: const Color(0xFF8B1919), // Dark red
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 3),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.25),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                _getIcon(_selectedIndex),
                color: Colors.white,
                size: 26,
              ),
            ),
          ),

          // ===== 3. NAV ITEMS (Icons + Labels) =====
          SizedBox(
            height: 70,
            child: Row(
              children: [
                _buildNavItem(0, "Home", Icons.home_filled),
                _buildNavItem(1, "Ticket", Icons.confirmation_number),
                _buildNavItem(2, "F&B", Icons.fastfood),
                _buildNavItem(3, "Profile", Icons.person),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNavItem(int index, String label, IconData icon) {
    bool isSelected = _selectedIndex == index;

    return Expanded(
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: SizedBox(
          height: 70,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon fades out when selected
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: isSelected ? 0.0 : 1.0,
                child: Icon(icon, color: Colors.white, size: 24),
              ),
              const SizedBox(height: 4),
              Text(
                label,
                style: GoogleFonts.poppins(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  IconData _getIcon(int index) {
    switch (index) {
      case 0:
        return Icons.home_filled;
      case 1:
        return Icons.confirmation_number;
      case 2:
        return Icons.fastfood;
      case 3:
        return Icons.person;
      default:
        return Icons.home;
    }
  }
}
