import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../screens/onboarding_screen.dart';
class ChooseRoleScreen extends StatelessWidget {
  const ChooseRoleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppColors.getHealixGradient(), // نفس الخلفية
        child: SafeArea( // عشان المحتوى ما يدخلش في "النوتش" بتاع الموبايل
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30), // مسافة من اليمين والشمال
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 1. اللوجو (مصغر قليلاً عن شاشة البداية)
                Image.asset(
                  'assets/images/logo.png',
                  width: 120,
                  height: 120,
                ),
                
                const SizedBox(height: 40),

                // 2. النص التوجيهي
                Text(
                  "Choose your role",
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontFamily: GoogleFonts.robotoMono().fontFamily,
                    letterSpacing: 1.0,
                  ),
                ),

                const SizedBox(height: 30),

                // 3. الأزرار (استخدام الويدجت المخصص اللي عملناه تحت)
                RoleButton(
                  label: "Patient",
                  icon: Icons.person_outline,
                  onTap: () {
                     Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const OnboardingScreen()),
                    );
                  },
                ),
                
                const SizedBox(height: 15), // مسافة بين الأزرار

                RoleButton(
                  label: "Doctor",
                  icon: Icons.medical_services_outlined,
                  onTap: () {
                    print("Doctor Selected");
                     // هنا هنحط كود الانتقال لصفحة تسجيل دخول الدكتور
                  },
                ),

                const SizedBox(height: 15),

                RoleButton(
                  label: "Other", // (صيدلي - فني أشعة...)
                  icon: Icons.science_outlined, // أيقونة معمل أو تحاليل
                  onTap: () {
                    print("Other Selected");
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// --- هذا هو الويدجت المخصص للزرار (Custom Widget) ---
// بدل ما نكتب كود الـ Container والـ Border 3 مرات، كتبناه مرة واحدة هنا
class RoleButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const RoleButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12), // عشان تأثير الضغطة يكون دائري
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 1.5), // الإطار الأبيض
          borderRadius: BorderRadius.circular(12), // الحواف الدائرية
          // color: Colors.transparent, // الخلفية شفافة
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.white, size: 24), // الأيقونة
            const SizedBox(width: 15), // مسافة بين الأيقونة والنص
            Text(
              label,
              style: TextStyle(
                fontSize: 18,
                color: Colors.white,
                fontFamily: GoogleFonts.robotoMono().fontFamily,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}