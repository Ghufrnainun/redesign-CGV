import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    // DATA DINAMIS (nanti bisa dari API)
    final String name = "Gupron Jawa";
    final String userId = "usr1212842910";
    final String phone = "081233445566";
    final String cardNumber = "6699 1212 1098 1234";
    final String points = "1,900,212";

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(context),
              _buildUserInfo(name, userId, phone),
              _buildMemberCard(name, cardNumber),
              _buildPaymentSection(),
              _buildRewardSection(points),
              _buildFeatureSection(),
              _buildOtherSection(),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================
  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
          Image.asset("assets/images/cgv1_logo.png", height: 22),
          const Spacer(),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person_outline)),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.notifications_none),
          ),
        ],
      ),
    );
  }

  // ================= USER INFO =================
  Widget _buildUserInfo(String name, String userId, String phone) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 24,
            backgroundColor: Colors.black,
            child: Icon(Icons.crop_square, color: Colors.white),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name,
                  style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w600, fontSize: 14)),
              Text(userId, style: const TextStyle(fontSize: 11)),
              Text(phone, style: const TextStyle(fontSize: 11)),
            ],
          )
        ],
      ),
    );
  }

  // ================= MEMBER CARD =================
  Widget _buildMemberCard(String name, String cardNumber) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset(
              "assets/images/cgv_card_bg.png", // BACKGROUND KARTU
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            left: 16,
            bottom: 24,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600)),
                const SizedBox(height: 4),
                Text(cardNumber,
                    style: GoogleFonts.inter(
                        color: Colors.white70, fontSize: 12)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= PAYMENT =================
  Widget _buildPaymentSection() {
    return _buildSection("Payment Options", [
      _paymentItem("DANA"),
      _paymentItem("Gopay"),
      _paymentItem("Bank"),
    ]);
  }

  Widget _paymentItem(String name) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.red),
      title: Text(name),
      trailing: const Text("Registered",
          style: TextStyle(color: Colors.red, fontSize: 12)),
    );
  }

  // ================= REWARD =================
  Widget _buildRewardSection(String points) {
    return Column(
      children: [
        _buildSection("Rewards", [
          ListTile(
            leading: const Icon(Icons.stars, color: Colors.amber),
            title: Text("$points Points"),
            subtitle: const Text("Trade your point for free tickets or F&B"),
          ),
        ]),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              _smallButton("Vouchers"),
              const SizedBox(width: 12),
              _smallButton("Coupons"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _smallButton(String text) {
    return Expanded(
      child: Container(
        height: 44,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Text(text, style: const TextStyle(color: Colors.white)),
      ),
    );
  }

  // ================= FEATURE =================
  Widget _buildFeatureSection() {
    return _buildSection("My Features", [
      _feature("Movie Diary"),
      _feature("Watchlist"),
      _feature("Event"),
      _feature("Free Wifi"),
    ]);
  }

  Widget _feature(String title) {
    return ListTile(
      leading: const Icon(Icons.circle, color: Colors.red),
      title: Text(title),
    );
  }

  // ================= OTHERS =================
  Widget _buildOtherSection() {
    return _buildSection("Others", [
      _other("FAQ & Contact Us"),
      _other("Settings"),
    ]);
  }

  Widget _other(String text) {
    return ListTile(
      leading: const Icon(Icons.settings, color: Colors.red),
      title: Text(text),
      trailing: const Icon(Icons.chevron_right),
    );
  }

  // ================= UTIL =================
  Widget _buildSection(String title, List<Widget> children) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              style: GoogleFonts.poppins(
                  fontSize: 14, fontWeight: FontWeight.w600)),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 6)
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
