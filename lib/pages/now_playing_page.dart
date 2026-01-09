import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NowPlayingPage extends StatefulWidget {
  const NowPlayingPage({super.key});

  @override
  State<NowPlayingPage> createState() => _NowPlayingPageState();
}

class _NowPlayingPageState extends State<NowPlayingPage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Mock Data
  final List<Map<String, dynamic>> _nowPlayingMovies = [
    {
      'image': 'assets/images/chainsaw-man-reze.jpg',
      'title': 'Chainsaw Man The Movie: Reze Arc',
      'rating': '9.5',
      'duration': '115m',
      'age': '13+',
    },
    {
      'image': 'assets/images/Agak-Laen-poster.jpg',
      'title': 'Rangga & Cinta',
      'rating': '9.2',
      'duration': '119m',
      'age': '13+',
    },
    {
      'image': 'assets/images/zootopia_two.jpg',
      'title': 'Zootopia 2',
      'rating': '9.8',
      'duration': '100m',
      'age': 'SU',
    },
    {
      'image': 'assets/images/news1.jpg',
      'title': 'Getih Ireng',
      'rating': '8.5',
      'duration': '95m',
      'age': '17+',
    },
    {
      'image': 'assets/images/Jujutsu-poster.jpg',
      'title': 'Jujutsu Kaisen 0',
      'rating': '9.3',
      'duration': '105m',
      'age': '13+',
    },
  ];

  final List<Map<String, dynamic>> _comingSoonMovies = [
    {
      'image': 'assets/images/Zootopia-Poster.jpg',
      'title': 'Zootopia 2',
      'date': '20 Nov 2025',
    },
    {
      'image': 'assets/images/Jujutsu-poster.jpg',
      'title': 'Avatar Fire And Ash',
      'date': '20 Nov 2025',
    },
    {
      'image': 'assets/images/promo2.jpg',
      'title': 'Sampai Titik Terakhirmu',
      'date': '25 Dec 2025',
    },
    {
      'image': 'assets/images/news2.jpg',
      'title': 'Predator Badlands',
      'date': '01 Jan 2026',
    },
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // 1. Text Scale Clamping agar tidak meledak di device setting font besar
    return MediaQuery(
      data: MediaQuery.of(context).copyWith(textScaler: TextScaler.linear(1.0)),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: const Color(0xFFFF9999),
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),

          // 2. TabBar Rapih & Indicator Tipis
          title: TabBar(
            controller: _tabController,
            dividerColor: Colors.transparent, // Remove M3 divider
            indicatorColor: Colors.white,
            indicatorWeight: 3,
            indicatorSize:
                TabBarIndicatorSize.label, // Indicator matches text width
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white.withOpacity(0.7),
            labelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
            tabs: const [
              Tab(text: "Sedang Tayang"),
              Tab(text: "Akan Datang"),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: [
            _buildGrid(_nowPlayingMovies, isComingSoon: false),
            _buildGrid(_comingSoonMovies, isComingSoon: true),
          ],
        ),
      ),
    );
  }

  Widget _buildGrid(
    List<Map<String, dynamic>> movies, {
    required bool isComingSoon,
  }) {
    return GridView.builder(
      physics: const BouncingScrollPhysics(),
      // F) Padding page
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      itemCount: movies.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12, // A) Spacing konsisten
        mainAxisSpacing: 12,
        // Option 1: mainAxisExtent
        // Total Height Calculation est:
        // Poster (Height depends on width, say width is ~160 -> Height ~220)
        // + Gap (6) + Title (16) + Gap (4) + Meta (14) ~ 260-280ish?
        // Let's safe bet around 310-320 to fit poster aspect ratio 0.72 properly.
        mainAxisExtent: 310,
      ),
      itemBuilder: (context, index) {
        final movie = movies[index];
        return _buildMovieCard(movie, isComingSoon: isComingSoon);
      },
    );
  }

  // 2) Widget MovieCard Reusable
  Widget _buildMovieCard(
    Map<String, dynamic> movie, {
    required bool isComingSoon,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min, // E) Jangan spaceBetween
      children: [
        // B) Poster
        ClipRRect(
          borderRadius: BorderRadius.circular(14),
          child: AspectRatio(
            aspectRatio: 0.72, // Agar tidak liar
            child: Image.asset(
              movie['image'],
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Colors.grey[200],
                  child: const Center(
                    child: Icon(Icons.broken_image, color: Colors.grey),
                  ),
                );
              },
            ),
          ),
        ),

        // D) Spacing internal
        const SizedBox(height: 8),

        // C) Typography
        Text(
          movie['title'],
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleSmall,
        ),

        const SizedBox(height: 4),

        // Meta Info
        if (isComingSoon)
          Text(
            movie['date'],
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              color: const Color(0xFFFF5252), // Keep color override
            ),
          )
        else
          Row(
            children: [
              const Icon(
                Icons.star_rounded,
                color: Color(0xFFFFB300),
                size: 14,
              ),
              const SizedBox(width: 4),
              Text(
                movie['rating'],
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(width: 8),

              Text(
                movie['duration'],
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: Colors.grey[700]),
              ),

              const Spacer(),

              // Badge Umur
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey[300]!),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  movie['age'],
                  style: Theme.of(context).textTheme.labelSmall,
                ),
              ),
            ],
          ),
      ],
    );
  }
}
