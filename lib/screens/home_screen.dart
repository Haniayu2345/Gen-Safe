import 'package:flutter/material.dart';
import 'gen_play_screen.dart';
import 'gen_fren_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _showIntroPopup());
  }

  // ==============================
  // POPUP GEN-FREN INTRO
  // ==============================
  void _showIntroPopup() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.symmetric(horizontal: 25, vertical: 40),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 270,
                padding: const EdgeInsets.only(top: 110, left: 20, right: 20, bottom: 25),
                decoration: BoxDecoration(
                  color: const Color(0xFF6B1677),
                  borderRadius: BorderRadius.circular(25),
                  image: const DecorationImage(
                    image: AssetImage('assets/images/frame128.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Text(
                      'Kenalan dulu sama Gen-Fren!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Si bot seru yang bisa jawab pertanyaanmu kapan aja.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 12,
                        height: 1.4,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE5B8F4),
                        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        elevation: 0,
                      ),
                      child: const Text(
                        'Ayo Kenalan!',
                        style: TextStyle(
                          color: Color(0xFF6B1677),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Positioned(
                top: -70,
                child: Image.asset(
                  'assets/images/genfren.png',
                  width: 200,
                  height: 190,
                  fit: BoxFit.contain,
                ),
              ),
              Positioned(
                bottom: -30,
                child: GestureDetector(
                  onTap: () => Navigator.pop(context),
                  child: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                    size: 26,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ==============================
  // BUILD HOME
  // ==============================
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: const Color(0xFF6B1677),
        unselectedItemColor: Colors.grey,
        currentIndex: 0,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(icon: Icon(Icons.people_alt_outlined), label: 'Gen Friend'),
          BottomNavigationBarItem(icon: Icon(Icons.child_care_outlined), label: 'Gen X'),
          BottomNavigationBarItem(icon: Icon(Icons.videogame_asset_outlined), label: 'Gen Play'),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // ==============================
            // HEADER COMPACT
            // ==============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Image.asset('assets/images/logoUtama.png', height: 40),
                  const Icon(Icons.info_outline, color: Colors.black87, size: 24),
                ],
              ),
            ),

            // BAGIAN ATAS (maskot + background)
            Stack(
              children: [
                ClipPath(
                  clipper: BottomCurveClipper(),
                  child: Container(
                    width: double.infinity,
                    height: 220,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/home3.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                Positioned.fill(
                  child: Align(
                    alignment: Alignment.center,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(40),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black12.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/maskot.png', height: 80),
                          const SizedBox(width: 15),
                          const Flexible(
                            child: Text(
                              'Hi, Friends!\nLet’s Explore Together',
                              style: TextStyle(
                                color: Color(0xFF6B1677),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                height: 1.3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 25),

            // ==============================
            // CEK KESEHATAN (GRADIENT)
            // ==============================
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color.fromRGBO(200, 179, 203, 1), Color.fromRGBO(225, 207, 209, 1), Color.fromRGBO(250, 235, 215, 1)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Image.asset('assets/images/nurse.png', height: 70),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Cek Kesehatan mu bareng GEN-Safe Yuk!',
                          style: TextStyle(
                            color: Color(0xFF6B1677),
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            height: 1.3,
                          ),
                        ),
                        const SizedBox(height: 10),
                        ElevatedButton.icon(
                          onPressed: () {
                            print('Menuju halaman tes kesehatan...');
                          },
                          icon: const Icon(Icons.airplanemode_active_rounded,
                              size: 16, color: Colors.white),
                          label: const Text(
                            'Yuk Mulai Tes',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                          ),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFE91E63),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(25),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                            elevation: 0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            // ==============================
            // GEN-PLAY & GEN-FREN
            // ==============================
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Expanded(
                    child: _buildCuteCard(
                      topColor: const Color(0xFFFFE4EC),
                      image: 'assets/images/genplay.png',
                      title: 'Gen-Play',
                      subtitle: 'Belajar sambil main seru',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GenPlayScreen()),
                        );
                      },
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: _buildCuteCard(
                      topColor: const Color(0xFFFFF1E5),
                      image: 'assets/images/genfren.png',
                      title: 'Gen-Fren',
                      subtitle: 'Ngobrol seru bareng Ocha',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const GenFrenScreen()),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  // ==============================
  // CARD GEN-PLAY / GEN-FREN
  // ==============================
  Widget _buildCuteCard({
    required Color topColor,
    required String image,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return StatefulBuilder(
      builder: (context, setLocalState) {
        bool isPressed = false;

        return MouseRegion(
          cursor: SystemMouseCursors.click,
          child: GestureDetector(
            onTapDown: (_) => setLocalState(() => isPressed = true),
            onTapUp: (_) {
              setLocalState(() => isPressed = false);
              Future.delayed(const Duration(milliseconds: 100), onTap);
            },
            onTapCancel: () => setLocalState(() => isPressed = false),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 120),
              transform: Matrix4.identity()..scale(isPressed ? 0.95 : 1.0),
              height: 135,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12.withOpacity(isPressed ? 0.05 : 0.15),
                    blurRadius: isPressed ? 3 : 8,
                    offset: Offset(0, isPressed ? 1 : 4),
                  ),
                ],
                border: Border.all(
                  color: isPressed ? const Color(0xFF6B1677).withOpacity(0.3) : Colors.transparent,
                  width: 1.2,
                ),
              ),
              child: Column(
                children: [
                  Container(
                    height: 70,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: topColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(25),
                        bottom: Radius.circular(40),
                      ),
                    ),
                    child: Center(child: Image.asset(image, height: 55)),
                  ),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: Color(0xFFD81B60),
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            subtitle,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.black54,
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ==============================
// CLIPPER BOTTOM
// ==============================
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width / 2, size.height - 10, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}
