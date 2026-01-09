import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomHeader extends StatelessWidget {
  final bool isHome;
  final bool useBorder; // For the profile page style
  final VoidCallback? onBackPressed;

  const CustomHeader({
    super.key,
    this.isHome = false,
    this.useBorder = false,
    this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    // 1. CONTENT INSIDE THE CONTAINER
    // For Home/Fnb: Logo + SearchBar + Icons
    // For Profile: Logo + Spacer + Icons (No SearchBar based on design)
    Widget innerContent;

    if (useBorder) {
      // Profile style inner content
      innerContent = Row(
        children: [
          Image.asset(
            'assets/images/cgv_logo.png',
            width: 50,
            fit: BoxFit.contain,
            errorBuilder: (c, o, s) => Text(
              "CGV",
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const Spacer(),
          const Icon(Icons.person_outline, color: Colors.black87),
          const SizedBox(width: 12),
          const Icon(Icons.notifications_outlined, color: Colors.black87),
        ],
      );
    } else {
      // Standard Header content
      innerContent = Row(
        children: [
          Image.asset(
            'assets/images/cgv_logo.png',
            width: 50,
            fit: BoxFit.contain,
            errorBuilder: (c, o, s) => Text(
              "CGV",
              style: GoogleFonts.poppins(
                color: Colors.red,
                fontWeight: FontWeight.bold,
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.black12),
              ),
              child: TextField(
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  hintText: "",
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.grey,
                    size: 20,
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.only(bottom: 14),
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          const Icon(Icons.person_outline, color: Colors.black87),
          const SizedBox(width: 12),
          const Icon(Icons.notifications_outlined, color: Colors.black87),
        ],
      );
    }

    // 2. CONTAINER DECORATION
    Widget containerWidget = innerContent;
    if (useBorder) {
      containerWidget = Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50), // Fully rounded like pill
          border: Border.all(color: Colors.black, width: 1.5),
        ),
        child: innerContent,
      );
    } else {
      containerWidget = Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
        child: innerContent,
      );
    }

    // 3. FINAL LAYOUT COMPOSITION
    if (isHome) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            color: const Color(0xFFFF9999).withOpacity(0.3),
            child: SafeArea(bottom: false, child: containerWidget),
          ),
        ],
      );
    } else if (useBorder) {
      // Profile Page Layout: [Arrow if back exists] + [ Logo ... Icons ]
      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Row(
            children: [
              if (onBackPressed != null)
                GestureDetector(
                  onTap: onBackPressed,
                  child: const Padding(
                    padding: EdgeInsets.only(right: 12),
                    child: Icon(
                      Icons.arrow_back,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                ),
              Expanded(child: containerWidget),
            ],
          ),
        ),
      );
    } else {
      // Standard Page (like F&B)
      return SafeArea(bottom: false, child: containerWidget);
    }
  }
}
