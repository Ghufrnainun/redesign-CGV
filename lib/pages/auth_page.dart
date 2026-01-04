import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'main_page.dart'; // Navigasi ke Main Page (Shell) biar ada navbar

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  // Controller buat ngatur Slide Halaman
  final PageController _pageController = PageController();

  // 0 = Login, 1 = Sign Up
  int _currentPage = 0;

  // Password Visibility State
  bool _isLoginPasswordVisible = false;
  bool _isSignupPasswordVisible = false;
  bool _rememberMe = false; // Checkbox state

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true, // Biar keyboard gak nutupin
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 20), // Jarak atas dikit
              // 1. LOGO CGV (FIXED)
              Image.asset(
                'assets/images/cgv_logo.png',
                width: 120,
                height: 60,
                fit: BoxFit.contain,
              ),

              const SizedBox(height: 30),

              // 2. TOGGLE BUTTON (FIXED)
              Container(
                width: 250,
                height: 55,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    // Animasi Background Merah
                    AnimatedAlign(
                      duration: const Duration(milliseconds: 350),
                      curve: Curves.easeInOutCubic,
                      alignment: _currentPage == 0
                          ? Alignment.centerLeft
                          : Alignment.centerRight,
                      child: Container(
                        width: 125,
                        height: 50,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE53935),
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFFE53935).withOpacity(0.3),
                              blurRadius: 6,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Teks Login & Sign Up
                    Row(
                      children: [
                        _buildToggleButton("LOGIN", 0),
                        _buildToggleButton("SIGN UP", 1),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 30),

              // 3. PAGE VIEW (SCROLLABLE CONTENT)
              // Pakai Expanded biar dia ngisi sisa layar
              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics:
                      const BouncingScrollPhysics(), // Efek mentul pas di ujung
                  onPageChanged: (index) {
                    setState(() {
                      _currentPage = index;
                    });
                  },
                  children: [
                    // Wrap with SingleChildScrollView biar cuma kontennya yg scroll
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _buildLoginForm(),
                      ),
                    ),
                    SingleChildScrollView(
                      physics: const BouncingScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24.0),
                        child: _buildSignUpForm(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- WIDGET HELPER ---

  // Tombol Toggle Text
  Widget _buildToggleButton(String text, int index) {
    bool isActive = _currentPage == index;
    return Expanded(
      child: GestureDetector(
        onTap: () {
          // Perintah buat geser halaman (Slide Animation)
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 350),
            curve: Curves.easeInOutCubic,
          );
        },
        child: Container(
          color: Colors.transparent, // Biar bisa diklik
          alignment: Alignment.center,
          child: Text(
            text,
            style: TextStyle(
              fontFamily: 'DreamGlory', // FONT CUSTOM LU
              fontSize: 16, // Dikecilin dikit dari 18
              color: isActive
                  ? Colors.white
                  : Colors.grey[600], // Pasif warna abu biar beda
              fontWeight: FontWeight.bold,
              shadows: isActive
                  ? [
                      Shadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 2,
                        offset: const Offset(0, 1),
                      ),
                    ]
                  : [], // Shadow dikit buat yg aktif textnya
            ),
          ),
        ),
      ),
    );
  }

  // --- FORM LOGIN ---
  Widget _buildLoginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Halo, Temankuu!!",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        _buildTextField("Email atau Nomor HP", icon: Icons.email_outlined),
        const SizedBox(height: 16),
        _buildTextField(
          "Password",
          isPassword: true,
          icon: Icons.lock_outline,
          isObscure: !_isLoginPasswordVisible,
          onSuffixPressed: () {
            setState(() {
              _isLoginPasswordVisible = !_isLoginPasswordVisible;
            });
          },
        ),

        const SizedBox(height: 10),

        // Inget Aku & Lupa Password
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Switch(
                  value: _rememberMe,
                  onChanged: (v) {
                    setState(() {
                      _rememberMe = v;
                    });
                  },
                  activeColor: const Color(0xFFE53935),
                ),
                Text("Ingat Aku", style: GoogleFonts.inter(fontSize: 12)),
              ],
            ),
            Text(
              "Lupa Password?",
              style: GoogleFonts.inter(color: Colors.blue, fontSize: 12),
            ),
          ],
        ),

        const SizedBox(height: 20),

        // TOMBOL SIGN IN
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {
              // Navigasi ke Main Page (bukan HomePage) biar ada Navbar
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MainPage()),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              elevation: 4,
              shadowColor: const Color(0xFFE53935).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Masuk",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
        const Divider(color: Colors.grey),
        const SizedBox(height: 20),

        // GOOGLE BUTTON
        _buildGoogleButton("Atau masuk pakai Google"),

        const SizedBox(height: 16), // Jarak fix lebih rapat
        Center(
          child: TextButton(
            onPressed: () => _pageController.animateToPage(
              1,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
            ),
            child: RichText(
              text: TextSpan(
                text: "Belum punya akun? ",
                style: GoogleFonts.inter(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "Yuk Daftar!",
                    style: GoogleFonts.inter(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  // --- FORM SIGN UP ---
  Widget _buildSignUpForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Halo, Temankuu!!",
          style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),

        _buildTextField("Nama Lengkap Kamu", icon: Icons.person_outline),
        const SizedBox(height: 12),
        _buildTextField(
          "Nomor HP Kamu",
          isNumber: true,
          icon: Icons.phone_android_outlined,
        ),
        const SizedBox(height: 12),
        _buildTextField("Email Kamu", icon: Icons.email_outlined),
        const SizedBox(height: 12),
        _buildTextField(
          "Password Kamu",
          isPassword: true,
          icon: Icons.lock_outline,
          isObscure: !_isSignupPasswordVisible,
          onSuffixPressed: () {
            setState(() {
              _isSignupPasswordVisible = !_isSignupPasswordVisible;
            });
          },
        ),

        const SizedBox(height: 10),

        Row(
          children: [
            Switch(
              value: _rememberMe,
              onChanged: (v) {
                setState(() {
                  _rememberMe = v;
                });
              },
              activeColor: const Color(0xFFE53935),
            ),
            Text("Ingat Aku", style: GoogleFonts.inter(fontSize: 12)),
          ],
        ),

        const SizedBox(height: 20),

        // TOMBOL DAFTAR
        SizedBox(
          width: double.infinity,
          height: 50,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFE53935),
              elevation: 4,
              shadowColor: const Color(0xFFE53935).withOpacity(0.4),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text(
              "Daftar",
              style: GoogleFonts.poppins(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
        ),

        const SizedBox(height: 20),
        const Divider(color: Colors.grey),
        const SizedBox(height: 20),

        _buildGoogleButton("Atau masuk pakai Google"),

        const SizedBox(height: 16), // Jarak fix lebih rapat
        Center(
          child: TextButton(
            onPressed: () => _pageController.animateToPage(
              0,
              duration: Duration(milliseconds: 350),
              curve: Curves.easeInOutCubic,
            ),
            child: RichText(
              text: TextSpan(
                text: "Sudah punya akun? ",
                style: GoogleFonts.inter(color: Colors.grey),
                children: [
                  TextSpan(
                    text: "Masuk aja!",
                    style: GoogleFonts.inter(color: Colors.blue),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  Widget _buildTextField(
    String hint, {
    bool isPassword = false,
    bool isNumber = false,
    IconData? icon,
    bool isObscure = false,
    VoidCallback? onSuffixPressed,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        obscureText: isPassword ? isObscure : false,
        keyboardType: isNumber ? TextInputType.phone : TextInputType.text,
        style: GoogleFonts.inter(fontSize: 14), // Font input user
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: GoogleFonts.inter(color: Colors.grey[400], fontSize: 13),
          prefixIcon: icon != null
              ? Icon(icon, color: const Color(0xFFE53935).withOpacity(0.8))
              : null,
          filled: true,
          fillColor: Colors.transparent,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: Color(0xFFE53935), width: 1.5),
          ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
          suffixIcon: isPassword
              ? IconButton(
                  icon: Icon(
                    isObscure
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    color: Colors.grey,
                  ),
                  onPressed: onSuffixPressed,
                )
              : null,
        ),
      ),
    );
  }

  // GOOGLE BUTTON
  Widget _buildGoogleButton(String text) {
    return Container(
      width: double.infinity,
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFF333333),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {}, // Add functionality here
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/icons/google.png', width: 24, height: 24),
              const SizedBox(width: 12),
              Text(
                text,
                style: GoogleFonts.inter(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
