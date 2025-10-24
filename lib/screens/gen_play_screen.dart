import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../pages/question_page1.dart'; // yang udah kamu buat

class GenPlayScreen extends StatefulWidget {
  const GenPlayScreen({super.key});

  @override
  State<GenPlayScreen> createState() => _GenPlayScreenState();
}

class _GenPlayScreenState extends State<GenPlayScreen> {
  List<bool> isExpandedList = [];
  List<int?> pressedSubIndex = [];
  int? pressedMainIndex;
  int activeIndex = 0;

  final List<Map<String, dynamic>> games = [
    {
      "title": "Ayo Kenalan Sama Tubuh Kamu",
      "played": false,
      "sub": [
        {"text": "Apa itu pubertas?", "done": false},
        {"text": "Pentingnya menjaga organ reproduksi", "done": false},
      ]
    },
    {
      "title": "Waspada dan Kenali Risiko IMS",
      "played": false,
      "sub": [
        {"text": "Cara penularan IMS", "done": false},
        {"text": "Pencegahan sejak dini", "done": false},
      ],
    },
    {
      "title": "Mengenal Alat Kontrasepsi",
      "played": false,
      "sub": [
        {"text": "Jenis-jenis kontrasepsi", "done": false},
        {"text": "Kapan sebaiknya digunakan?", "done": false},
      ],
    },
    {
      "title": "Bijak dan Bertanggung Jawab",
      "played": false,
      "sub": [
        {"text": "Sikap dalam hubungan", "done": false},
        {"text": "Menghargai diri sendiri", "done": false},
      ],
    },
  ];

  @override
  void initState() {
    super.initState();
    isExpandedList = List.generate(games.length, (index) => false);
    pressedSubIndex = List.generate(games.length, (index) => null);
  }

  void markGamePlayed(int index) {
    setState(() {
      games[index]["played"] = true;
      isExpandedList[index] = true;
      for (var sub in games[index]["sub"]) {
        sub["done"] = true;
      }
    });
  }

  void _showNotAvailableMessage(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          "Halaman ini belum tersedia 😅",
          style: GoogleFonts.poppins(fontSize: 13),
        ),
        backgroundColor: Colors.deepPurple,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 65,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            Image.asset('assets/images/logo.png', width: 36),
            const SizedBox(width: 8),
            Text(
              "Gen-Play",
              style: GoogleFonts.poppins(
                color: Colors.deepPurple,
                fontWeight: FontWeight.w600,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.help_outline, color: Colors.black54),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Mulai Game!",
              style: GoogleFonts.poppins(
                color: Colors.deepPurple,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    left: 22,
                    top: 0,
                    bottom: 0,
                    child: CustomPaint(painter: DashedLinePainter()),
                  ),
                  ListView.builder(
                    itemCount: games.length,
                    itemBuilder: (context, index) {
                      final game = games[index];
                      final isPressedMain = pressedMainIndex == index;
                      final isActive = activeIndex == index;
                      final isPlayed = game["played"] == true;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 25),
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            AnimatedPositioned(
                              duration: const Duration(milliseconds: 250),
                              left: 16,
                              top: 55,
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 250),
                                width: 12,
                                height: 12,
                                decoration: BoxDecoration(
                                  color: isActive
                                      ? Colors.deepOrange
                                      : Colors.deepPurple.shade100,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 35),
                              child: Column(
                                children: [
                                  GestureDetector(
                                    onTapDown: (_) {
                                      setState(() => pressedMainIndex = index);
                                    },
                                    onTapUp: (_) async {
                                      setState(() {
                                        pressedMainIndex = null;
                                        activeIndex = index;
                                      });

                                      // kalau sudah dimainkan → konfirmasi ulang
                                      if (isPlayed) {
                                        final bool? replay = await showDialog(
                                          context: context,
                                          builder: (context) => AlertDialog(
                                            title: Text(
                                              "Ulangi Game?",
                                              style: GoogleFonts.poppins(
                                                  fontWeight: FontWeight.w600),
                                            ),
                                            content: Text(
                                              "Kamu sudah pernah main game ini. Mau ulangi lagi?",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 14),
                                            ),
                                            actions: [
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, false),
                                                child: Text("Tidak",
                                                    style: GoogleFonts.poppins(
                                                        color: Colors.grey)),
                                              ),
                                              TextButton(
                                                onPressed: () => Navigator.pop(
                                                    context, true),
                                                child: Text("Ya",
                                                    style: GoogleFonts.poppins(
                                                        color:
                                                            Colors.deepPurple)),
                                              ),
                                            ],
                                          ),
                                        );

                                        if (replay != true) return;
                                      }

                                      // arahkan ke halaman pertanyaan sesuai index
                                      Widget? targetPage;
                                      switch (index) {
                                        case 0:
                                          targetPage =
                                              const QuestionPage1(); // yang udah kamu buat
                                          break;
                                        case 1:
                                        case 2:
                                        case 3:
                                          targetPage = null; // belum dibikin
                                          break;
                                      }

                                      if (targetPage == null) {
                                        _showNotAvailableMessage(context);
                                        return;
                                      }

                                      final played = await Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => targetPage!),
                                      );

                                      if (played == true) {
                                        markGamePlayed(index);
                                      }
                                    },
                                    child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 120),
                                      curve: Curves.easeInOut,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 14, horizontal: 14),
                                      decoration: BoxDecoration(
                                        color: isPressedMain
                                            ? Colors.deepPurple.shade50
                                            : Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                          color: Colors.deepPurple.shade50,
                                          width: 1.5,
                                        ),
                                        boxShadow: [
                                          if (!isPressedMain)
                                            BoxShadow(
                                              color:
                                                  Colors.grey.withOpacity(0.15),
                                              blurRadius: 8,
                                              offset: const Offset(0, 3),
                                            ),
                                        ],
                                      ),
                                      child: Row(
                                        children: [
                                          Expanded(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 16),
                                              child: Text(
                                                game["title"],
                                                style: GoogleFonts.poppins(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w600,
                                                  color: Colors.black87,
                                                ),
                                              ),
                                            ),
                                          ),
                                          ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(14),
                                            child: Image.asset(
                                              'assets/images/card_gen_play1.png',
                                              width: 100,
                                              height: 80,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  AnimatedSize(
                                    duration: const Duration(milliseconds: 250),
                                    curve: Curves.easeInOut,
                                    child: game["played"]
                                        ? Column(
                                            children: List.generate(
                                              game["sub"].length,
                                              (i) {
                                                final isPressed =
                                                    pressedSubIndex[index] == i;
                                                return AnimatedContainer(
                                                  duration: const Duration(
                                                      milliseconds: 100),
                                                  margin: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 8,
                                                      horizontal: 10),
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 14,
                                                      vertical: 12),
                                                  decoration: BoxDecoration(
                                                    color: isPressed
                                                        ? Colors
                                                            .deepPurple.shade50
                                                        : Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                      color: Colors
                                                          .deepPurple.shade50,
                                                      width: 1.5,
                                                    ),
                                                    boxShadow: [
                                                      if (!isPressed)
                                                        BoxShadow(
                                                          color: Colors.grey
                                                              .withOpacity(0.15),
                                                          blurRadius: 8,
                                                          offset: const Offset(
                                                              0, 3),
                                                        ),
                                                    ],
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Expanded(
                                                        child: Text(
                                                          game["sub"][i]["text"],
                                                          style: GoogleFonts
                                                              .poppins(
                                                            fontSize: 13,
                                                            fontWeight:
                                                                FontWeight.w500,
                                                          ),
                                                        ),
                                                      ),
                                                      if (game["sub"][i]
                                                          ["done"])
                                                        const Icon(
                                                          Icons.check_circle,
                                                          color: Colors.green,
                                                          size: 20,
                                                        ),
                                                    ],
                                                  ),
                                                );
                                              },
                                            ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 3,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.group_outlined), label: 'Gen Friend'),
          BottomNavigationBarItem(
              icon: Icon(Icons.wc_outlined), label: 'Gen X'),
          BottomNavigationBarItem(
              icon: Icon(Icons.sports_esports_outlined), label: 'Gen Play'),
        ],
      ),
    );
  }
}

// 🔹 Garis putus-putus di kiri
class DashedLinePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    const double dashHeight = 6, dashSpace = 4;
    double startY = 0;
    final paint = Paint()
      ..color = Colors.grey.shade300
      ..strokeWidth = 2;

    while (startY < size.height) {
      canvas.drawLine(Offset(0, startY), Offset(0, startY + dashHeight), paint);
      startY += dashHeight + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
