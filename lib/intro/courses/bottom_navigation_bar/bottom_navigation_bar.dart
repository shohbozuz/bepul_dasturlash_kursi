import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:bepul_dasturlash_kursi/intro/courses/Colors/color.dart';


class BottomNavigation extends StatefulWidget {
  final int selectedIndex;
  final Function(int) onTabChange;

  const BottomNavigation({
    required this.selectedIndex,
    required this.onTabChange,
  });

  @override
  _BottomNavigationState createState() => _BottomNavigationState();
}

class _BottomNavigationState extends State<BottomNavigation> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
        ),
        color: Colors.white,

      ),

      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
        child: GNav(
          backgroundColor: Colors.white,
          color: Colors.black26,
          activeColor: Colors.white70,
          tabBackgroundColor: AppColors.bottom_navigation,
          tabBorderRadius: 15,
          gap: 8,
          padding: EdgeInsets.all(12),
          tabs: const [
            GButton(
              icon: Icons.home,
              text: 'Asosiy',
            ),
            GButton(
              icon: Icons.library_books,
              text: 'Online kutubxona',
            ),
            GButton(
              icon: Icons.settings,
              text: 'Sozlanmalar',
            ),
          ],
          selectedIndex: widget.selectedIndex,
          onTabChange: widget.onTabChange,
        ),
      ),
    );
  }
}