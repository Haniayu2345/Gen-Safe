import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/answer_button.dart';

class QuestionPage3 extends StatefulWidget {
  const QuestionPage3({super.key});

  @override
  State<QuestionPage3> createState() => _QuestionPage3State();
}

class _QuestionPage3State extends State<QuestionPage3>
    with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  String? selectedAnswer;

  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;

  final List<Map<String, dynamic>> questions = [
    {
      "image": "assets/images/card1.png",
      "answer": "Ya",
      "explanationTrue":
          "Yes, bener banget! Ganti pembalut tiap 4–6 jam itu penting banget biar tetap bersih dan gak lembap, supaya area kewanitaan kamu juga tetap sehat.",
      "explanationFalse":
          "Ups, kurang tepat nihi. Pembalut harus diganti tiap 4–6 jam ya, Gennies. Kalau kelamaan, bisa bikin iritasi dan jadi sarang bakteri.",
    },
    {
      "image": "assets/images/card2.png",
      "answer": "Tidak",
      "explanationTrue":
          "Yes, bener banget! Ganti pembalut itu wajib tiap beberapa jam biar tetap fresh dan bebas dari  iritasi.",
      "explanationFalse":
          "Ups, kurang tepat nih! Pakai pembalut seharian tanpa ganti malah bikin lembap dan bisa  menimbulkan bau atau infeksi.",
    },
    {
      "image": "assets/images/card3.png",
      "answer": "Ya",
      "explanationTrue":
          "Yes, bener banget! Cukup pakai air bersih aja kok, nggak perlu sabun khusus yang bisa ganggu pH alami area kewanitaan.",
      "explanationFalse":
          "Ups, kurang tepat nih! Justru air bersih udah cukup banget buat jaga kebersihan organ kewanitaan kamu, Gennies!",
    },
    {
      "image": "assets/images/card4.png",
      "answer": "Tidak",
      "explanationTrue":
          "Yes, bener banget! Yes, bener banget! Celana yang longgar dan nyerap keringat bikin area kewanitaan kamu bisa  ‘bernapas’ dan tetap sehat.",
      "explanationFalse":
          "Ups, kurang tepat nih! Celana dalam yang terlalu ketat malah bikin lembap dan gak nyaman.",
    },
    {
      "image": "assets/images/card5.png",
      "answer": "Ya",
      "explanationTrue":
          "Yes, bener banget!  Jaga kebersihan setelah olahraga biar gak lembap dan terhindar dari bakteri  karena keringat.",
      "explanationFalse":
          "Ups, kurang tepat nih! Setelah olahraga itu wajib banget jaga kebersihan, biar kulit dan area  kewanitaan kamu tetap sehat dan segar.",
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
    _controller.forward();
  }

  void _nextQuestion() {
    _controller.reverse();
    setState(() {
      selectedAnswer = null;
      if (currentIndex < questions.length - 1) {
        currentIndex++;
      } else {
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
    final isCorrect = selectedAnswer == question["answer"];

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(
            "Bagian III",
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        body: Stack(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Progress indicator dengan warna
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                  child: Column(
                    children: [
                      // Progress bar dengan warna pink
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: LinearProgressIndicator(
                          value: (currentIndex + 1) / questions.length,
                          color: Colors.pinkAccent,
                          backgroundColor: Colors.grey.shade200,
                          minHeight: 8,
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Nomor pertanyaan dengan warna pink
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          "${currentIndex + 1}/5",
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
                
                // gambar pertanyaan dengan margin lebih besar
                Expanded(
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      margin: const EdgeInsets.only(top: 40), // Tambah margin atas
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
                
                // tombol jawaban dengan margin lebih besar
                Padding(
                  padding: const EdgeInsets.only(bottom: 100), // Kurangi dari 160 ke 100
                  child: Column(
                    children: [
                      // Spacer untuk memberi jarak antara gambar dan tombol
                      const SizedBox(height: 40),
                      Row(
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
                          const SizedBox(width: 30), // Tambah jarak antara tombol
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
                            isCorrect ? "Yes, bener banget!" : "Ups, kurang tepat nihi",
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