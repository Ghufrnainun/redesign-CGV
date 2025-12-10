import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            _buildCustomHeader(),
            _buildLocationBar(),

            // KONTEN SCROLL KE BAWAH
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. HERO BANNER (SLIDER KANAN KIRI)
                    // Gw ganti jadi scroll horizontal
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          _buildHeroBannerItem(
                            'assets/images/chainsaw-man-reze.jpg',
                          ), // Ganti nama file sesuai punya lu
                          _buildHeroBannerItem(
                            'assets/images/zootopia_two.jpg',
                          ),
                        ],
                      ),
                    ),

                    // B. MEMBER CARD
                    _buildMemberCard(),

                    // C. SEDANG TAYANG (POSTER ASSETS)
                    _buildSectionTitle("Sedang Tayang"),
                    _buildMovieScrollList(),

                    // D. PROMOTION
                    _buildSectionTitle("Promotion"),
                    _buildPromoBanner(),

                    // E. FOOD & BEVERAGE
                    _buildSectionTitle("Food & Beverage"),
                    _buildFoodBanner(),

                    // F. SPECIAL FEATURE
                    _buildSectionTitle("CGV Special Feature"),
                    _buildSpecialFeatureList(),

                    // G. NEWS
                    _buildSectionTitle("News"),
                    _buildNewsItem(
                      "20 Film Seru ini Tayang bulan Desember 2025!",
                      "Rabu, 10 Desember",
                      "assets/images/news1.jpg",
                    ),
                    _buildNewsItem(
                      "Rekomendasi Film Keluarga Terbaik di CGV!",
                      "Rabu, 10 Desember",
                      "assets/images/news2.jpg",
                    ),

                    const SizedBox(height: 120), // Spacer bawah
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET COMPONENTS ---

  // 1. HEADER (LOGO DARI ASSETS)
  Widget _buildCustomHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: const Color(0xFFFF9999),
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  // LOGO CGV DARI ASSETS
                  Image.asset(
                    'assets/images/cgv_logo.png', // Pastikan file ini ada
                    width: 43,
                    height: 19,
                    fit: BoxFit.contain,
                    errorBuilder: (c, o, s) => const Text(
                      "CGV",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),
          ),
          const SizedBox(width: 16),
          const Icon(Icons.person_outline, color: Colors.black87),
          const SizedBox(width: 12),
          const Icon(Icons.notifications_outlined, color: Colors.black87),
        ],
      ),
    );
  }

  Widget _buildLocationBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      color: Colors.white,
      child: Row(
        children: [
          const Icon(
            Icons.location_on_outlined,
            size: 16,
            color: Colors.black54,
          ),
          const SizedBox(width: 6),
          Text(
            "Jakarta",
            style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
          ),
          const Spacer(),
          const Icon(Icons.keyboard_arrow_down, size: 16),
        ],
      ),
    );
  }

  // WIDGET BARU: HERO BANNER ITEM
  Widget _buildHeroBannerItem(String imagePath) {
    return Container(
      width:
          350, // Lebar banner (biar ada sisa dikit di kanan buat kode kalo bisa discroll)
      height: 220,
      margin: const EdgeInsets.only(right: 4), // Jarak antar banner
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          // Gambar Background
          SizedBox(
            width: double.infinity,
            height: double.infinity,
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.black,
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.white),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMemberCard() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFFEF5350), Color(0xFFFF8A65)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.red.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.person, color: Colors.white, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        "Jullphyw",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(Icons.stars, color: Colors.yellow, size: 14),
                      const SizedBox(width: 4),
                      Text(
                        "Gold Member",
                        style: GoogleFonts.poppins(
                          color: Colors.white,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
          const SizedBox(height: 16),
          Stack(
            children: [
              Container(height: 4, color: Colors.black26),
              Container(height: 4, width: 150, color: Colors.white),
            ],
          ),
          const SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "300 / 500 poin",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          Row(
            children: [
              Text(
                "Lihat Semua",
                style: GoogleFonts.poppins(
                  color: Colors.red,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Icon(Icons.chevron_right, color: Colors.red, size: 16),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMovieScrollList() {
    final List<Map<String, dynamic>> movies = [
      {
        'image': 'assets/images/Agak-Laen-poster.jpg',
        'title': 'Agak Laen',
        'rating': '9.1',
        'duration': '1J 59M',
      },
      {
        'image': 'assets/images/Chainsaw-man-Reze-poster.jpg',
        'title': 'Chainsaw Man Reze Arc',
        'rating': '9.5',
        'duration': '1J 55M',
      },
      {
        'image': 'assets/images/Zootopia-Poster.jpg',
        'title': 'Zootopia 2',
        'rating': '8.8',
        'duration': '1J 40M',
      },
      {
        'image': 'assets/images/Jujutsu-poster.jpg',
        'title': 'Jujutsu Kaisen 0',
        'rating': '9.3',
        'duration': '1J 45M',
      },
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(movies.length, (index) {
          final movie = movies[index];

          return Container(
            margin: const EdgeInsets.only(right: 16),
            width: 130,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Container(
                    height: 190,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Image.asset(
                      movie['image'],
                      width: double.infinity,
                      height: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (c, o, s) =>
                          const Center(child: Icon(Icons.broken_image)),
                    ),
                  ),
                ),
                const SizedBox(height: 8),

                // 3. JUDUL DINAMIS
                Text(
                  movie['title'], // <--- Panggil Judul dari Map
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),

                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.star, color: Colors.orange, size: 14),
                    Text(
                      " ${movie['rating']}", // <--- Panggil Rating dari Map
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      movie['duration'], // <--- Panggil Durasi dari Map
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPromoBanner() {
    // 1. DATA PROMO (GAMBAR + TEKS DI BAWAHNYA)
    final List<Map<String, dynamic>> promo = [
      {
        'image': 'assets/images/promo1.png',
        'title': 'CGV Zooper Experice di Central Park!',
      },
      {
        // Pastiin file ini ada di assets ya, kalo ga ada dia bakal error/blank
        'image': 'assets/images/promo2.jpg',
        'title':
            'Dapatkan Trading Card Zootopia untuk pembelian 2 ticket nonton Zootopia di CGV!',
      },
      {
        'image': 'assets/images/promo3.jpg',
        'title': 'CGV MISSION TO KOREA! #SiAPPUntung',
      },
    ];

    return Column(
      children: [
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(promo.length, (index) {
              final item = promo[index];

              return Container(
                margin: const EdgeInsets.only(right: 16),
                width: 280,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        color: Colors.grey[300],
                        child: Image.asset(
                          item['image'],
                          fit: BoxFit.cover,
                          errorBuilder: (c, o, s) => const Center(
                            child: Icon(Icons.broken_image, color: Colors.grey),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),
                    Text(
                      item['title'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.inter(
                        color: Colors.black87,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }

  Widget _buildFoodBanner() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. GAMBAR (BANNER)
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Container(
              height: 150,
              width: double.infinity,
              color: Colors.grey[300],
              child: Image.asset(
                'assets/images/fnb1.png',
                fit: BoxFit.cover,
                errorBuilder: (c, o, s) => const Center(
                  child: Icon(Icons.broken_image, color: Colors.grey),
                ),
              ),
            ),
          ),

          const SizedBox(height: 12),
          Text(
            "Pesan makanan lewat App CGV",
            style: GoogleFonts.inter(
              fontSize: 12,
              color: Colors.black87,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSpecialFeatureList() {
    // List gambar dummy buat feature
    List<String> featureImages = [
      'assets/images/Chainsaw-man-Reze-poster.jpg',
      'assets/images/Jujutsu-poster.jpg',
      'assets/images/Zootopia-Poster.jpg',
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(featureImages.length, (index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.deepPurple,
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(featureImages[index]),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Colors.black87, Colors.transparent],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                "Feature ${index + 1}",
                style: GoogleFonts.poppins(color: Colors.white, fontSize: 12),
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildNewsItem(String title, String date, String imagePath) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  date,
                  style: GoogleFonts.inter(
                    color: Colors.grey,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          // GAMBAR NEWS DARI ASSETS
          Container(
            width: 90,
            height: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                image: AssetImage(imagePath),
                fit: BoxFit.cover,
                onError: (e, s) {}, // Handle error diem aja
              ),
            ),
          ),
        ],
      ),
    );
  }
}
