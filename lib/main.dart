import 'package:flutter/material.dart';
import 'pages/auth_page.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        textTheme: TextTheme(
          // HEADLINES (Poppins)
          titleLarge: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.bold, // AppBar title
            color: const Color(0xFF1D1D1D),
          ),
          titleMedium: GoogleFonts.poppins(
            fontSize: 14,
            fontWeight: FontWeight.w600, // Tabs, Section Headers
            color: const Color(0xFF1D1D1D),
          ),
          titleSmall: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w600, // Card Titles
            color: const Color(0xFF1D1D1D),
            height: 1.2,
          ),
          // BODY (Inter)
          bodyMedium: GoogleFonts.inter(
            fontSize: 12,
            fontWeight: FontWeight.normal, // Regular text
            color: Colors.black87,
          ),
          bodySmall: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500, // Meta info (rating, duration)
            color: Colors.black87,
          ),
          labelSmall: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.bold, // Badges (Age)
            color: Colors.black54,
          ),
        ),
      ),
      home: const AuthPage(),
    );
  }
}
