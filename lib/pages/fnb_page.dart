import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redesign_cgv/widgets/custom_header.dart';

class FnbPage extends StatefulWidget {
  const FnbPage({super.key});

  @override
  State<FnbPage> createState() => _FnbPageState();
}

class _FnbPageState extends State<FnbPage> {
  String _selectedLocation = "Jakarta"; // Default location

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.85,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
          ),
          child: Column(
            children: [
              // HANDLE BAR
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 12, bottom: 8),
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),

              // SEARCH BAR
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search",
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                  ),
                ),
              ),

              // CURRENT LOCATION
              ListTile(
                title: RichText(
                  text: TextSpan(
                    text: "$_selectedLocation ",
                    style: GoogleFonts.poppins(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: "· Lokasi Sekarang",
                        style: GoogleFonts.inter(
                          color: Colors.grey,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () => Navigator.pop(context),
              ),
              const Divider(height: 1),

              // LIST CITIES
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  children: [
                    _buildCityItem("Bekasi"),
                    _buildCityItem("Depok"),
                    _buildCityItem("Bogor"),
                    _buildCityItem("Tangerang"),
                    _buildCityItem("Serang"),
                    _buildCityItem("Cikarang"),
                    _buildCityItem("Karawang"),
                    _buildCityItem("Bandung"),
                    _buildCityItem("Tegal"),
                    _buildCityItem("Solo"),
                    _buildCityItem("Blitar"),
                    _buildCityItem("Surabaya"),
                    _buildCityItem("Malang"),
                    _buildCityItem("Jember"),
                    _buildCityItem("Balikpapan"),
                    _buildCityItem("Medan"),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCityItem(String city) {
    return Column(
      children: [
        ListTile(
          title: Text(
            city,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          onTap: () {
            setState(() {
              _selectedLocation = city;
            });
            Navigator.pop(context);
          },
        ),
        const Divider(height: 1, indent: 16, endIndent: 16),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 1. HEADER
            const CustomHeader(isHome: false),

            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // 2. BANNER
                    _buildBanner(),

                    const SizedBox(height: 24),

                    // 3. LOCATION BAR
                    _buildLocationBar(),

                    const SizedBox(height: 20),

                    // 4. BIOSKOP TERDEKAT TITLE
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text(
                        "Bioskop Terdekat",
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // 5. CINEMA LIST
                    _buildCinemaList(),

                    const SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      height: 180,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.network(
          "https://cdn.cgv.id/uploads/marketing/2409/MM_20240924151241.jpg", // CGV Food Banner
          fit: BoxFit.cover,
          width: double.infinity,
          height: double.infinity,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return Container(
              color: Colors.grey[200],
              child: Center(
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                            loadingProgress.expectedTotalBytes!
                      : null,
                  color: const Color(0xFFFF3D3D),
                ),
              ),
            );
          },
          errorBuilder: (context, error, stackTrace) {
            // Fallback to local asset if network fails
            return Image.asset(
              'assets/images/fnb1.png',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
              errorBuilder: (context, error, stackTrace) {
                // Absolute fallback if everything fails
                return Container(
                  alignment: Alignment.center,
                  color: const Color(0xFFFFD600),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.fastfood, size: 48, color: Colors.white),
                      const SizedBox(height: 8),
                      Text(
                        "CGV Food & Beverage",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Widget _buildLocationBar() {
    return Material(
      color: const Color(0xFFFF3333), // Reverted to Red
      child: InkWell(
        onTap: _showLocationPicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: const BoxDecoration(
            // No border needed for red style usually, or maybe a slight one?
            // Original red bar didn't have a bottom border like the white one.
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.white, // White icon
              ),
              const SizedBox(width: 8),
              Text(
                _selectedLocation,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: Colors.white, // White text
                ),
              ),
              const Spacer(),
              Text(
                "Ganti",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold, // Bold "Ganti"
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCinemaList() {
    final cinemas = [
      {
        'name': 'Sunter Mall',
        'distance': '10 km',
        'address': 'Living World, Lt. 2, Serpong',
      },
      {
        'name': 'Sunter Mall',
        'distance': '10 km',
        'address': 'Living World, Lt. 2, Serpong',
      }, // Duplicate as per image example
      {
        'name': 'Sunter Mall',
        'distance': '10 km',
        'address': 'Living World, Lt. 2, Serpong',
      },
    ];

    return Column(
      children: cinemas.map((cinema) {
        return Container(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey.shade200),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(16),
            title: Row(
              children: [
                Text(
                  cinema['name']!,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  cinema['distance']!,
                  style: GoogleFonts.inter(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: Text(
                cinema['address']!,
                style: GoogleFonts.inter(fontSize: 12, color: Colors.black54),
              ),
            ),
            trailing: const Icon(Icons.chevron_right, color: Colors.red),
            onTap: () {
              // Navigate to menu selection
            },
          ),
        );
      }).toList(),
    );
  }
}
