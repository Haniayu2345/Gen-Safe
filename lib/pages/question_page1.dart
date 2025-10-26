import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/answer_button.dart';

class QuestionPage1 extends StatefulWidget {
  const QuestionPage1({super.key});

  @override
  State<QuestionPage1> createState() => _QuestionPage1State();
}

class _QuestionPage1State extends State<QuestionPage1>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  int currentPart = 1; // Part 1 atau Part 2
  String? selectedAnswer;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      "image": "assets/images/question1_card1.png",
      "answer": "Ya",
      "explanationTrue":
          "Yes, bener banget! Semua orang bakal ngalamin pubertas, cuma waktunya bisa beda-beda.",
      "explanationFalse":
          "Ups, kurang tepat nih! Semua orang pas ngalamin pubertas kok, jadi kamu gak akan sendirian.",
    },
    {
      "image": "assets/images/question2_card1.png",
      "answer": "Tidak",
      "explanationTrue":
          "Yes, bener banget! Pubertas tiap orang beda timingnya. Ada yang duluan, ada yang belakangan,  semua normal kok.",
      "explanationFalse":
          "Ups, kurang tepat nih! Pubertas itu gak harus barengan. Kamu punya waktumu sendiri, Gennies!",
    },
    {
      "image": "assets/images/question3_card1.png",
      "answer": "Ya",
      "explanationTrue":
          "Yes, bener banget! Jerawat itu hal normal pas pubertas karena hormon lagi aktif.",
      "explanationFalse":
          "Ups, kurang tepat nih! Jerawat pas pubertas itu wajar banget, tandanya tubuh kamu lagi adaptasi sama hormon.",
    },
    {
      "image": "assets/images/question4_card1.png",
      "answer": "Tidak",
      "explanationTrue":
          "Yes, bener banget! Siklus haid saat itu emang belum stabil. Karena tubuh kamu lagi adaptasi sama perubahan hormon.",
      "explanationFalse":
          "Ups, kurang tepat nih! Haid yang belum teratur di awal itu normal banget kok!."
    },
    {
      "image": "assets/images/question5_card1.png",
      "answer": "Ya",
      "explanationTrue":
          "Yes, bener banget! Menstruasi pertama itu tanda jelas kalau tubuh kamu udah masuk masa pubertas.",
      "explanationFalse":
          "Ups, kurang tepat nih! Justru menstruasi pertama itu jadi bukti nyata kalau pubertas kamu udah mulai.",
    },
    // ===================== Soal 6–10 =====================
    {
      "image": "assets/images/question6_card1.png",
      "answer": "Ya",
      "explanationTrue": 
      "Yes, bener banget! Tumbuh payudara itu adalah salah satu tanda pertama tubuh cewek mulai  memasuki pubertas.",
      "explanationFalse": 
      "Ups, kurang tepat nih! Justru itu tanda jelas pubertas udah dimulai, lho. Tubuh kamu lagi  berkembang secara alami!",
    },
    {
      "image": "assets/images/question7_card1.png",
      "answer": "Tidak",
      "explanationTrue": 
      "Yes, bener banget! Kadang emosi itu bisa berubah cepat karena hormon lagi aktif banget. Totally  normal ya!",
      "explanationFalse": 
      "Ups, kurang tepat nih! Pas puber emang wajar banget kalo emosi suka gak stabil, karena hormon  lagi ngatur ulang banyak hal di tubuhmu.",
    },
    {
      "image": "assets/images/question8_card1.png",
      "answer": "Ya",
      "explanationTrue": 
      "Yes, bener banget! Pubertas juga ngaruh ke perasaan, bukan cuma fisik. Hormon bisa bikin mood  kamu berubah-ubah.",
      "explanationFalse": 
      "Ups, kurang tepat nih! Pubertas ngaruh ke tubuh dan perasaan kamu juga, makanya kadang mood  suka berubah tanpa alasan.",
    },
    {
      "image": "assets/images/question9_card1.png",
      "answer": "Tidak",
      "explanationTrue": 
      "Yes, bener banget! Totally normal ya Gennies! Itu tanda tubuh kamu lagi berkembang. Semua orang  ngalamin, jadi gak perlu khawatir.",
      "explanationFalse": 
      "Ups, kurang tepat nih! Rambut tumbuh di area itu wajar banget kok. Justru tandanya hormon  pubertas kamu lagi aktif.",
    },
    {
      "image": "assets/images/question10_card1.png",
      "answer": "Ya",
      "explanationTrue": 
      "Yes, bener banget! Itu tanda hormon lagi beradaptasi. Karena itu bagian dari proses tumbuh  dewasa.",
      "explanationFalse": 
      "Ups, kurang tepat nih! Gampang marah atau sensitif pas pubertas itu normal banget. Tubuh kamu  lagi menyesuaikan diri sama hormon baru.",
    },
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onSelectAnswer(String choice) {
    if (selectedAnswer != null) return;

    setState(() => selectedAnswer = choice);
    _controller.forward(); // langsung tampilkan overlay
  }

  void _nextQuestion() {
    _controller.reverse();
    setState(() {
      selectedAnswer = null;
      if (currentIndex < questions.length - 1) {
        currentIndex++;
        if (currentIndex == 5) {
          currentPart = 2;
        }
      } else {
        // semua soal selesai
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Kuis selesai! 🎉", style: GoogleFonts.poppins()),
            backgroundColor: Colors.green,
            duration: const Duration(seconds: 2),
          ),
        );
        Future.delayed(const Duration(seconds: 2), () => Navigator.pop(context, true));
      }
    });
  }

  Future<bool> _onWillPop() async {
    bool exitQuiz = false;
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          "Keluar dari kuis?",
          style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
        ),
        content: Text(
          "Kamu belum menyelesaikan kuis ini. Yakin mau kembali ke halaman utama?",
          style: GoogleFonts.poppins(),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text("Lanjutkan", style: GoogleFonts.poppins()),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.deepPurple,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () {
              exitQuiz = true;
              Navigator.pop(context);
            },
            child: Text("Tetap Keluar", style: GoogleFonts.poppins(color: Colors.white)),
          ),
        ],
      ),
    );
    return exitQuiz;
  }

  @override
  Widget build(BuildContext context) {
    final question = questions[currentIndex];
    final partStartIndex = currentPart == 1 ? 0 : 5;
    final partProgress = ((currentIndex - partStartIndex) + 1) / 5;
    final partNumber = (currentIndex - partStartIndex) + 1;
    final isCorrect = selectedAnswer == question["answer"];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          title: Text(
            "Bagian 1 – Part $currentPart",
            style: GoogleFonts.poppins(
              color: Colors.deepPurple,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: partProgress,
                          color: Colors.pinkAccent,
                          backgroundColor: Colors.grey.shade200,
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "$partNumber/5",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.pinkAccent,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // gambar pertanyaan
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      width: MediaQuery.of(context).size.width * 0.85,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          )
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(18),
                        child: Image.asset(
                          question["image"],
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                  ),
                ),
                // tombol jawaban
                Padding(
                  padding: const EdgeInsets.only(bottom: 160),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnswerButton(
                        text: "Tidak",
                        color: selectedAnswer == "Tidak"
                            ? Colors.redAccent
                            : Colors.transparent,
                        borderColor: Colors.redAccent,
                        textColor: selectedAnswer == "Tidak"
                            ? Colors.white
                            : Colors.redAccent,
                        onTap: () => _onSelectAnswer("Tidak"),
                      ),
                      const SizedBox(width: 20),
                      AnswerButton(
                        text: "Ya",
                        color: selectedAnswer == "Ya"
                            ? Colors.green
                            : Colors.transparent,
                        borderColor: Colors.green,
                        textColor: selectedAnswer == "Ya"
                            ? Colors.white
                            : Colors.green,
                        onTap: () => _onSelectAnswer("Ya"),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            // overlay hitam
            if (selectedAnswer != null)
              Positioned.fill(
                child: Container(color: Colors.black.withOpacity(0.6)),
              ),
            // slider penjelasan benar/salah
            if (selectedAnswer != null)
              SlideTransition(
                position: _slideAnimation,
                child: GestureDetector(
                  onTap: _nextQuestion,
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      padding:
                          const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20),
                        ),
                        border: Border(
                          top: BorderSide(
                            color: isCorrect ? Colors.green : Colors.red,
                            width: 6,
                          ),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 12,
                            offset: const Offset(0, -4),
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            isCorrect ? "Benar sekali!" : "Ups, kurang tepat",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: isCorrect ? Colors.green : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            isCorrect
                                ? question["explanationTrue"]
                                : question["explanationFalse"],
                            style: GoogleFonts.poppins(
                              fontSize: 13.5,
                              color: Colors.black87,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "Ketuk untuk lanjut",
                              style: GoogleFonts.poppins(
                                  fontSize: 12, color: Colors.grey),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
