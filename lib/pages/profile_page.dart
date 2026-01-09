import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:redesign_cgv/widgets/custom_header.dart';

class ProfilePage extends StatelessWidget {
  final Function(int)? onTabChange;

  const ProfilePage({super.key, this.onTabChange});

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
              CustomHeader(
                useBorder: true,
                onBackPressed: () {
                  onTabChange?.call(0); // Go back to Home tab
                },
              ),
              _buildUserInfo(context, name, userId, phone),
              _buildMemberCard(context, name, cardNumber),
              _buildPaymentSection(context),
              _buildRewardSection(context, points),
              _buildFeatureSection(context),
              _buildOtherSection(context),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  // ================= HEADER =================

  // ================= USER INFO =================
  // ================= USER INFO =================
  Widget _buildUserInfo(
    BuildContext context,
    String name,
    String userId,
    String phone,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(2), // Space for border
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(color: Colors.black, width: 2), // Black border
            ),
            child: const CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black,
              child: Icon(Icons.crop_square, color: Colors.white),
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name, style: Theme.of(context).textTheme.titleMedium),
              Text(userId, style: Theme.of(context).textTheme.bodySmall),
              Text(phone, style: Theme.of(context).textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  // ================= MEMBER CARD =================
  Widget _buildMemberCard(
    BuildContext context,
    String name,
    String cardNumber,
  ) {
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
                Text(
                  name,
                  style: Theme.of(
                    context,
                  ).textTheme.titleMedium?.copyWith(color: Colors.white),
                ),
                const SizedBox(height: 4),
                Text(
                  cardNumber,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ================= PAYMENT =================
  Widget _buildPaymentSection(BuildContext context) {
    return _buildSection(context, "Payment Options", [
      _paymentItem(context, "DANA"),
      _paymentItem(context, "Gopay"),
      _paymentItem(context, "Bank"),
    ]);
  }

  Widget _paymentItem(BuildContext context, String name) {
    return ListTile(
      leading: const CircleAvatar(backgroundColor: Colors.red),
      title: Text(name, style: Theme.of(context).textTheme.bodyMedium),
      trailing: Text(
        "Registered",
        style: Theme.of(
          context,
        ).textTheme.bodySmall?.copyWith(color: Colors.red),
      ),
    );
  }

  // ================= REWARD =================
  Widget _buildRewardSection(BuildContext context, String points) {
    return Column(
      children: [
        _buildSection(context, "Rewards", [
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
              _smallButton(context, "Vouchers"),
              const SizedBox(width: 12),
              _smallButton(context, "Coupons"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _smallButton(BuildContext context, String text) {
    return Expanded(
      child: Material(
        color: Colors.red,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            // TODO: Navigate to vouchers/coupons
          },
          child: Container(
            height: 44,
            alignment: Alignment.center,
            child: Text(
              text,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

  // ================= FEATURE =================
  Widget _buildFeatureSection(BuildContext context) {
    return _buildSection(context, "My Features", [
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
  Widget _buildOtherSection(BuildContext context) {
    return _buildSection(context, "Others", [
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
  Widget _buildSection(
    BuildContext context,
    String title,
    List<Widget> children,
  ) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 24, 16, 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 6),
              ],
            ),
            child: Column(children: children),
          ),
        ],
      ),
    );
  }
}
