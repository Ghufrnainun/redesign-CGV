import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Kita pake SafeArea biar konten gak ketutup status bar HP
      body: SafeArea(
        child: Column(
          children: [
            // =========================================
            // BAGIAN 1: HEADER (PINK & LOKASI)
            // =========================================
            _buildCustomHeader(),
            _buildLocationBar(),

            // =========================================
            // BAGIAN 2: ISI HALAMAN (BISA DI-SCROLL)
            // =========================================
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // A. HERO BANNER (Trailer Film)
                    Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.black, // Placeholder gambar trailer
                      child: Center(
                        child: Text(
                          "BANNER TRAILER FILM",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),

                    // B. MEMBER CARD (Merah Gradient)
                    _buildMemberCard(),

                    // C. SECTION: SEDANG TAYANG
                    _buildSectionTitle("Sedang Tayang"),
                    _buildMovieScrollList(), // List film geser samping
                    // D. SECTION: PROMOTION
                    _buildSectionTitle("Promotion"),
                    Container(
                      height: 120,
                      color: Colors.grey[300],
                      margin: EdgeInsets.symmetric(horizontal: 16),
                      child: Center(child: Text("Promo Banner Slider")),
                    ),

                    _buildSectionTitle("Food & Beverage"),
                    _buildFoodBanner(),

                    // F. SECTION: SPECIAL FEATURE
                    _buildSectionTitle("CGV Special Feature"),
                    _buildSpecialFeatureList(),

                    // G. SECTION: NEWS
                    _buildSectionTitle("News"),
                    _buildNewsItem(),
                    _buildNewsItem(),

                    // Spacer bawah biar gak mentok navbar
                    SizedBox(height: 100),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- WIDGET KECIL-KECIL (METHOD) BIAR KODINGAN RAPI ---

  // 1. Header Pink Atas
  Widget _buildCustomHeader() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      color: Colors.redAccent, // Warna dasar pink/merah
      child: Row(
        children: [
          // Search Bar (Putih)
          Expanded(
            child: Container(
              height: 40,
              padding: EdgeInsets.symmetric(horizontal: 10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  // Anggap ini Logo CGV text merah
                  Text(
                    "CGV*",
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  Spacer(),
                  Icon(Icons.search, color: Colors.grey),
                ],
              ),
            ),
          ),
          SizedBox(width: 16),
          // Icon User & Notif
          Icon(Icons.person_outline, color: Colors.white),
          SizedBox(width: 12),
          Icon(Icons.notifications_outlined, color: Colors.white),
        ],
      ),
    );
  }

  // 2. Bar Lokasi
  Widget _buildLocationBar() {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.white,
      child: Row(
        children: [
          Icon(Icons.location_on_outlined, size: 18),
          SizedBox(width: 8),
          Text("Jakarta", style: TextStyle(fontWeight: FontWeight.bold)),
          Spacer(),
          Icon(Icons.keyboard_arrow_down),
        ],
      ),
    );
  }

  // 3. Kartu Member Merah
  Widget _buildMemberCard() {
    return Container(
      margin: EdgeInsets.all(16),
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.red[400], // Harusnya gradient, pake solid dulu
        borderRadius: BorderRadius.circular(12),
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
                  Text(
                    "Jullphyw",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Gold Member",
                    style: TextStyle(color: Colors.white70, fontSize: 12),
                  ),
                ],
              ),
              Icon(Icons.chevron_right, color: Colors.white),
            ],
          ),
          SizedBox(height: 10),
          // Progress Bar Palsu
          LinearProgressIndicator(
            value: 0.6,
            backgroundColor: Colors.red[800],
            color: Colors.white,
          ),
          SizedBox(height: 4),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              "300 / 500 poin",
              style: TextStyle(color: Colors.white, fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Judul Section (Reuseable)
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            "Lihat Semua >",
            style: TextStyle(color: Colors.red, fontSize: 12),
          ),
        ],
      ),
    );
  }

  // 5. List Film Horizontal
  Widget _buildMovieScrollList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // <--- KUNCI BIAR BISA GESER SAMPING
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(3, (index) {
          // Bikin 3 poster dummy
          return Container(
            margin: EdgeInsets.only(right: 12),
            width: 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Poster
                Container(
                  height: 180,
                  color: Colors.grey, // Placeholder gambar
                ),
                SizedBox(height: 8),
                Text(
                  "Chainsaw Man",
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(
                  "⭐ 9.5",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }

  Widget _buildFoodBanner() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16),
      height: 120, // Tinggi banner
      width: double.infinity, // Lebar mentok
      decoration: BoxDecoration(
        color: Colors.amber, // Placeholder warna kuning CGV
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          // Kiri: Gambar Popcorn
          Container(
            width: 100,
            color: Colors.amber[700],
            child: Icon(Icons.fastfood, size: 50, color: Colors.white),
          ),
          // Kanan: Teks
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Paket Seru",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  Text("Diskon popcorn + minum!",
                      style: TextStyle(fontSize: 12)),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  // F. Special Feature (Kotak 3 biji geser samping)
  Widget _buildSpecialFeatureList() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal, // Geser samping lagi
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: List.generate(3, (index) {
          return Container(
            margin: EdgeInsets.only(right: 12),
            width: 140, // Lebih lebar dikit dari poster film
            height: 140, // Bentuk kotak
            decoration: BoxDecoration(
              color: Colors.purple[100], // Placeholder ungu
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: Text("Feature ${index + 1}",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ),
          );
        }),
      ),
    );
  }

// G. News Item (Teks Kiri, Gambar Kanan)
  Widget _buildNewsItem() {
    return Container(
      margin: EdgeInsets.fromLTRB(16, 0, 16, 16), // Margin bawah 16
      child: Row(
        children: [
          // 1. Teks Berita (Pake Expanded biar ngisi sisa ruang)
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Update Film Baru Bulan Oktober yang wajib kamu tonton!",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                  maxLines: 2, // Maksimal 2 baris
                  overflow:
                      TextOverflow.ellipsis, // Kalau kepanjang kasih '...'
                ),
                SizedBox(height: 8),
                Text("Kamis, 9 Oktober",
                    style: TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          SizedBox(width: 12), // Jarak teks ke gambar

          // 2. Gambar Thumbnail Berita (Kanan)
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: Colors.orange[300],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(Icons.newspaper, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
