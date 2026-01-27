import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/custom_textfield.dart'; // استدعاء الويدجت المشترك
import 'login_screen.dart'; // عشان نربط بصفحة الدخول

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: AppColors.getHealixGradient(), // نفس الخلفية
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // 1. زرار الرجوع
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context); // يرجع خطوة للوراء
                    },
                  ),
                ),
                
                const SizedBox(height: 30),

                // 2. العنوان
                Text(
                  "Hello!\nRegister to get started",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),

                const SizedBox(height: 30),

                // 3. حقول الإدخال (زيادة حقل الاسم وتأكيد الباسورد)
                const CustomTextField(hintText: "Username"),
                const SizedBox(height: 15),
                
                const CustomTextField(hintText: "Email"),
                const SizedBox(height: 15),
                
                const CustomTextField(
                  hintText: "Password",
                  isPassword: true,
                  suffixIcon: Icons.visibility_off_outlined,
                ),
                const SizedBox(height: 15),

                const CustomTextField(
                  hintText: "Confirm password",
                  isPassword: true,
                  suffixIcon: Icons.visibility_off_outlined,
                ),

                const SizedBox(height: 30),

                // 4. زرار التسجيل (Register Button)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: () {
                      // TODO: Implement Registration Logic
                      print("Register Button Pressed");
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(color: Colors.white, fontSize: 18),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // 5. التسجيل بالسوشيال ميديا
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white54)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or Register with", style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Colors.white54)),
                  ],
                ),

                const SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSocialButton("assets/images/facebook.png"),
                    _buildSocialButton("assets/images/google.png"),
                    _buildSocialButton("assets/images/apple.png"),
                  ],
                ),
                
                const Spacer(),

                // 6. الرابط بصفحة الدخول (Login Link)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account? ", style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        // الانتقال لصفحة الدخول
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        "Login Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // نفس الدالة المساعدة للأيقونات
  Widget _buildSocialButton(String imagePath) {
    return Container(
      width: 90,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.grey.shade300),
      ),
      padding: const EdgeInsets.all(12),
      child: Image.asset(imagePath, fit: BoxFit.contain),
    );
  }
}