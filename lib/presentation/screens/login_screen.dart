import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../widgets/custom_textfield.dart';
import '../screens/register_screen.dart';
import '../screens/patient/patient_home_screen.dart';
import '../../data/services/auth_service.dart';

// 1. حولناها لـ StatefulWidget عشان نقدر نغير حالة الشاشة (Loading)
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // تعريف الكنترولرز
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  
  // 2. تعريف السيرفس (عشان الخطأ يروح)
  final AuthService _authService = AuthService();

  // 3. متغير عشان نعرف إحنا بنحمل ولا لأ
  bool _isLoading = false;

  // دالة تسجيل الدخول
  Future<void> _handleLogin() async {
    // التأكد إن الحقول مش فاضية
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in all fields"), backgroundColor: Colors.red),
      );
      return;
    }

    setState(() {
      _isLoading = true; // شغل التحميل
    });

    try {
      // الاتصال بالسيرفر
      await _authService.login(
        _emailController.text.trim(), 
        _passwordController.text.trim()
      );

      if (mounted) {
        // نجاح! رسالة خضراء وانتقال للصفحة الرئيسية
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Login Successful!"), backgroundColor: Colors.green),
        );
        
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const PatientHomeScreen()),
          (route) => false,
        );
      }
    } catch (e) {
      // فشل! اعرض رسالة الخطأ
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString().replaceAll("Exception:", "")), backgroundColor: Colors.red),
        );
      }
    } finally {
      // وقف التحميل سواء نجح أو فشل
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  void dispose() {
    // تنظيف الذاكرة
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          decoration: AppColors.getHealixGradient(),
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                
                // زرار الرجوع
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new, size: 18),
                    color: Colors.black,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
                
                const SizedBox(height: 40),

                // ترحيب
                Text(
                  "Welcome back!\nGlad to see you, Again!",
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: GoogleFonts.roboto().fontFamily,
                  ),
                ),

                const SizedBox(height: 40),

                // حقول الإدخال
                CustomTextField(
                   hintText: "Enter your email",
                   controller: _emailController,
                ),
                
                const SizedBox(height: 15),
                
                CustomTextField(
                   hintText: "Enter your password",
                  isPassword: true, // مجرد ما تقول true، هو هيحط العين ويشغلها لوحده
                  controller: _passwordController,
                ),

                // نسيت كلمة المرور
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Forgot Password?",
                      style: TextStyle(color: Colors.black54),
                    ),
                  ),
                ),

                const SizedBox(height: 30),

                // زرار تسجيل الدخول (Login Button)
                SizedBox(
                  width: double.infinity,
                  height: 55,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin, // لو بيحمل اقفل الزرار
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: _isLoading 
                        ? const CircularProgressIndicator(color: Colors.white) // علامة التحميل
                        : const Text(
                            "Login",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                  ),
                ),

                const SizedBox(height: 40),

                // تسجيل الدخول بالسوشيال ميديا
                const Row(
                  children: [
                    Expanded(child: Divider(color: Colors.white54)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text("Or Login with", style: TextStyle(color: Colors.white70)),
                    ),
                    Expanded(child: Divider(color: Colors.white54)),
                  ],
                ),

                const SizedBox(height: 20),

                // أيقونات السوشيال
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _buildSocialButton("assets/images/facebook.png"),
                    _buildSocialButton("assets/images/google.png"),
                    _buildSocialButton("assets/images/apple.png"),
                  ],
                ),
                
                const Spacer(),

                // إنشاء حساب جديد
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Don't have an account? ", style: TextStyle(color: Colors.white)),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                      child: const Text(
                        "Register Now",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
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