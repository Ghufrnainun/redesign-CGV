import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redesign_cgv/pages/now_playing_page.dart';
import 'package:redesign_cgv/widgets/custom_header.dart';

class HomePage extends StatefulWidget {
  final Function(int)? onTabChange;

  const HomePage({super.key, this.onTabChange});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final PageController _pageController = PageController(viewportFraction: 0.9);
  int _currentIndex = 0;
  String _selectedLocation = "Jakarta"; // Default location

  final List<String> _bannerImages = [
    'assets/images/chainsaw-man-reze.jpg',
    'assets/images/zootopia_two.jpg',
    'assets/images/Agak-Laen-poster.jpg',
  ];

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
            // HEADER
            // HEADER
            const CustomHeader(isHome: true),
            _buildLocationBar(),

            // KONTEN SCROLL KE BAWAH
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // HERO BANNER CAROUSEL
                    Column(
                      children: [
                        SizedBox(
                          height: 220,
                          child: PageView.builder(
                            controller: _pageController,
                            itemCount: _bannerImages.length,
                            onPageChanged: (index) {
                              setState(() {
                                _currentIndex = index;
                              });
                            },
                            itemBuilder: (context, index) {
                              return _buildHeroBannerItem(_bannerImages[index]);
                            },
                          ),
                        ),
                        const SizedBox(height: 12),
                        // INDICATOR DOTS
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            _bannerImages.length,
                            (index) => Container(
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              width: _currentIndex == index ? 24 : 8,
                              height: 8,
                              decoration: BoxDecoration(
                                color: _currentIndex == index
                                    ? const Color(0xFFFF5252)
                                    : Colors.grey[300],
                                borderRadius: BorderRadius.circular(4),
                              ),
                            ),
                          ),
                        ),
                      ],
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
                    _buildSectionTitle(
                      "Food & Beverage",
                      onTap: () {
                        widget.onTabChange?.call(2); // Pindah ke tab F&B
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        widget.onTabChange?.call(2); // Pindah ke tab F&B
                      },
                      child: _buildFoodBanner(),
                    ),

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

  Widget _buildLocationBar() {
    return Material(
      color: Colors.white,
      child: InkWell(
        onTap: _showLocationPicker,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(color: Colors.grey.withOpacity(0.1)),
            ),
          ),
          child: Row(
            children: [
              const Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.black54,
              ),
              const SizedBox(width: 8),
              Text(
                _selectedLocation,
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                ),
              ),
              const Spacer(),
              const Icon(
                Icons.keyboard_arrow_down,
                size: 20,
                color: Colors.black54,
              ),
            ],
          ),
        ),
      ),
    );
  }

  // WIDGET BARU: HERO BANNER ITEM
  Widget _buildHeroBannerItem(String imagePath) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 8,
      ), // Added vertical for shadow
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomLeft,
          children: [
            // Image
            Positioned.fill(
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey[800],
                    child: const Center(
                      child: Icon(Icons.broken_image, color: Colors.white54),
                    ),
                  );
                },
              ),
            ),

            // Gradient Overlay
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
                  stops: const [0.6, 1.0],
                ),
              ),
            ),

            // Optional: Add Text or Button on Banner if needed (preserving original doesn't have it, but overlay suggests it's ready)
            Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {},
                splashColor: Colors.white.withOpacity(0.1),
                child: Container(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMemberCard() {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            widget.onTabChange?.call(3); // Navigate to Profile tab
          },
          borderRadius: BorderRadius.circular(10),
          child: Container(
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
                            const Icon(
                              Icons.person,
                              color: Colors.white,
                              size: 16,
                            ),
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
                            const Icon(
                              Icons.stars,
                              color: Colors.yellow,
                              size: 14,
                            ),
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
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, {VoidCallback? onTap}) {
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
              color: const Color(0xFF1D1D1D),
            ),
          ),
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap:
                  onTap ??
                  () {
                    // Default action if no specific onTap is provided
                    // For "Sedang Tayang", we want to navigate to NowPlayingPage
                    if (title == "Sedang Tayang") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NowPlayingPage(),
                        ),
                      );
                    }
                  },
              borderRadius: BorderRadius.circular(4),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                child: Row(
                  children: [
                    Text(
                      "Lihat Semua",
                      style: GoogleFonts.poppins(
                        color: const Color(0xFFFF5252),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const Icon(
                      Icons.chevron_right,
                      color: Color(0xFFFF5252),
                      size: 16,
                    ),
                  ],
                ),
              ),
            ),
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
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(movies.length, (index) {
          final movie = movies[index];

          return Container(
            margin: const EdgeInsets.only(right: 16, bottom: 8),
            width: 140, // Increased width slightly
            child: InkWell(
              onTap: () {
                // Navigate to detail
              },
              borderRadius: BorderRadius.circular(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 210, // Taller for better proportion
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
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
                  const SizedBox(height: 10),

                  // 3. JUDUL DINAMIS
                  Text(
                    movie['title'],
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600,
                      fontSize: 14,
                      color: const Color(0xFF1D1D1D),
                    ),
                  ),

                  const SizedBox(height: 4),
                  Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFFB300),
                        size: 16,
                      ),
                      Text(
                        " ${movie['rating']}",
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          movie['duration'],
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            color: Colors.grey[600],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  Widget _buildPromoBanner() {
    // 1. DATA PROMO
    final List<Map<String, dynamic>> promo = [
      {
        'image': 'assets/images/promo1.png',
        'title': 'CGV Zooper Experice di Central Park!',
      },
      {
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
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: List.generate(promo.length, (index) {
              final item = promo[index];

              return Container(
                margin: const EdgeInsets.only(right: 16, bottom: 8),
                width: 280,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                  color: Colors.white,
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(12),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(12),
                          ),
                          child: Image.asset(
                            item['image'],
                            width: double.infinity,
                            fit: BoxFit.fitWidth,
                            errorBuilder: (c, o, s) {
                              return Container(
                                height: 150,
                                color: Colors.grey[200],
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12),
                          child: Text(
                            item['title'],
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.inter(
                              color: const Color(0xFF1D1D1D),
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
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
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(featureImages.length, (index) {
          return Container(
            margin: const EdgeInsets.only(right: 12),
            width: 140,
            height: 140,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 8,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(featureImages[index], fit: BoxFit.cover),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withOpacity(0.8),
                          Colors.transparent,
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Text(
                      "Feature ${index + 1}",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
          );
        }),
      ),
    );
  }

  Widget _buildNewsItem(String title, String date, String imagePath) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16, left: 16, right: 16),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {},
          borderRadius: BorderRadius.circular(12),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          height: 1.4,
                          color: const Color(0xFF1D1D1D),
                        ),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        date,
                        style: GoogleFonts.inter(
                          color: Colors.grey[600],
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // GAMBAR NEWS DARI ASSETS
              Container(
                width: 100,
                height: 75,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.08),
                      blurRadius: 4,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        Container(color: Colors.grey[200]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
