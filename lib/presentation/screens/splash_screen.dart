import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // تأكد من وجود الـ Import
import '../../core/constants/app_colors.dart';
import 'choose_role_screen.dart'; // لازم نعمل import للشاشة الجديدة

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  
  @override
  void initState() {
    super.initState();
    // دالة الانتقال بعد 3 ثواني
    Future.delayed(const Duration(seconds: 3), () {
      // الانتقال واستبدال الشاشة (عشان ميرجعش للسبلاش تاني لو داس back)
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const ChooseRoleScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppColors.getHealixGradient(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/logo.png',
              width: 250, 
              height: 250,
            ),
            const SizedBox(height: 40),
            Text(
              "All your medical data\nin one place",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24,
                color: Colors.white70,
                letterSpacing: 1.2,
                height: 1.5,
                fontFamily: GoogleFonts.robotoMono().fontFamily,
              ),
            ),
          ],
        ),
      ),
    );
  }
}