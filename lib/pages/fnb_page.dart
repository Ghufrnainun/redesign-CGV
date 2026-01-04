import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FnbPage extends StatelessWidget {
  const FnbPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          "Food & Beverage",
          style: GoogleFonts.poppins(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: _buildFoodBanner(),
        ),
      ),
    );
  }

  Widget _buildFoodBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: const Color(0xFFFFD600),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.12),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // TEXT KIRI
                Positioned(
                  left: 16,
                  top: 24,
                  right: 140,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "CGV Food & Beverage",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.red.shade700,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Pesan popcorn, hotdog & minuman sebelum nonton",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          color: Colors.black87,
                          height: 1.4,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // BUTTON
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 10,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "Order Sekarang",
                          style: GoogleFonts.poppins(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // IMAGE KANAN
                Positioned(
                  right: 0,
                  bottom: 0,
                  top: 0,
                  child: ClipRRect(
                    borderRadius: const BorderRadius.horizontal(
                      right: Radius.circular(14),
                    ),
                    child: Image.asset(
                      "assets/images/fnb1.png",
                      width: 150,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 10),

          Text(
            "Pesan lebih cepat, tanpa antre di bioskop",
            style: GoogleFonts.inter(fontSize: 11, color: Colors.grey[700]),
          ),
          const SizedBox(height: 100), // Padding untuk navbar
        ],
      ),
    );
  }
}
