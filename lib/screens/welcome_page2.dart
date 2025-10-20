import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'welcome_page3.dart';

class WelcomePage2 extends StatelessWidget {
  const WelcomePage2({super.key});

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(flex: 2),
              Column(
                children: [
                  Image.asset('assets/images/Ocha.png', width: 200, height: 200),
                  const SizedBox(height: 30),
                  Text(
                    "Hai Sobat Gennies!",
                    style: GoogleFonts.poppins(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromRGBO(79, 11, 87, 1),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Aku Ocha, sahabat virtual kamu di sini!\nAku bakal nemenin kamu buat ngobrol, curhat,\ndan cari info seputar masa remaja dan pubertas.",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: const Color.fromRGBO(157, 86, 127, 1),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const Spacer(flex: 3),
              Padding(
                padding: EdgeInsets.only(bottom: height * 0.05),
                child: SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (_, __, ___) => const WelcomePage3(),
                          transitionsBuilder: (_, animation, __, child) =>
                              SlideTransition(
                            position: Tween(
                              begin: const Offset(1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromRGBO(79, 11, 87, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    child: Text(
                      "Berikutnya",
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
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
