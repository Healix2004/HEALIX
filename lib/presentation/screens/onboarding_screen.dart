import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../screens/welcome_screen.dart';
// استدعي شاشة تسجيل الدخول (لسه هنعملها، فممكن تعملها import لما نخلص)
// import 'login_screen.dart'; 

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentIndex = 0;

  // هنا بنحط البيانات (الكلام والصور) لكل صفحة
  final List<Map<String, String>> _onboardingData = [
    {
      "image": "assets/images/onboarding_1.png",
      "title": "Find your doctor",
      "desc": "Easily find your doctor and book an appointment with ease."
    },
    {
      "image": "assets/images/onboarding_2.png",
      "title": "Store Medical Records",
      "desc": "Keep all your medical history and records in one safe place."
    },
    {
      "image": "assets/images/onboarding_3.png",
      "title": "Track your Health",
      "desc": "Monitor your health progress and get insights regularly."
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppColors.getHealixGradient(), // نفس الخلفية الموحدة
        child: SafeArea(
          child: Column(
            children: [
              // 1. زرار Skip فوق على اليمين
              // 1. زرار Skip
              Align(
                alignment: Alignment.topRight,
                child: TextButton(
                  onPressed: () {
                    // التعديل هنا: الانتقال لشاشة الترحيب
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const WelcomeScreen()),
                    );
                  },
                  child: const Text(
                    "Skip",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  ),
                ),
              ),

              const Spacer(flex: 1), // مسافة مرنة

              // 2. الجزء المتحرك (الصور والنصوص)
              SizedBox(
                height: 400, // ارتفاع منطقة العرض
                child: PageView.builder(
                  controller: _controller,
                  itemCount: _onboardingData.length,
                  onPageChanged: (index) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        // الصورة
                        Image.asset(
                          _onboardingData[index]["image"]!,
                          height: 250,
                        ),
                        const SizedBox(height: 20),
                        // العنوان
                        Text(
                          _onboardingData[index]["title"]!,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: GoogleFonts.robotoMono().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 10),
                        // الوصف
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 40),
                          child: Text(
                            _onboardingData[index]["desc"]!,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.white70,
                              height: 1.5,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),

              // 3. مؤشر الصفحات (Dots)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentIndex == index ? 12 : 8, // النقطة النشطة أكبر
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentIndex == index ? Colors.white : Colors.white38,
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const Spacer(flex: 2),

              // 4. زرار Next أو Get Started
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_currentIndex == _onboardingData.length - 1) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const WelcomeScreen()),);
                      } else {
                        // لو لسه، اقلب للصفحة اللي بعدها
                        _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeIn,
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Text(
                      _currentIndex == _onboardingData.length - 1
                          ? "Get Started"
                          : "Next",
                      style: const TextStyle(
                        color: AppColors.gradientEnd, // لون النص أزرق زي اللوجو
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
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