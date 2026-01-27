import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../patient/medical_records_screen.dart';

class PatientHomeScreen extends StatelessWidget {
  const PatientHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppColors.getHealixGradient(), // الخلفية الثابتة
        child: SafeArea(
          child: SingleChildScrollView( // عشان لو المحتوى طول نقدر نعمل سكرول
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                
                // 1. الجزء العلوي (الترحيب وصورة البروفايل)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Welcome, Maryam",
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          "How are you today?", // جملة إضافية صغيرة
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white70,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                      ],
                    ),
                    // صورة البروفايل (دائرة)
                    CircleAvatar(
                      radius: 25,
                      backgroundColor: Colors.white,
                      child: const CircleAvatar(
                        radius: 23,
                        backgroundImage: AssetImage('assets/images/logo.png'), // مؤقتاً لحد ما نحط صورة شخصية
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 30),

                // 2. شريط الخدمات السريع (القائمة الأفقية)
                // 2. شريط الخدمات السريع
                SizedBox(
                  height: 140, 
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      // زرار الروشيتات
                      _buildQuickActionCard(
                        "Prescriptions",
                        "assets/images/icon_prescriptions.png", 
                        () {
                          // TODO: انتقل لصفحة الروشيتات
                          print("Open Prescriptions Page");
                        },
                      ),
                      
                      const SizedBox(width: 15),
                      
                      // زرار المواعيد
                      _buildQuickActionCard(
                        "Appointments",
                        "assets/images/icon_appointments.png",
                        () {
                          // TODO: انتقل لصفحة الحجوزات
                          print("Open Appointments Page");
                        },
                      ),
                      
                      const SizedBox(width: 15),
                      
                      // زرار السجلات الطبية (ده اللي عليه العين في الصور)
                      _buildQuickActionCard(
                        "Medical Records",
                        "assets/images/icon_records.png",
                        () {
                           Navigator.push(
                             context, 
                             MaterialPageRoute(builder: (context) =>  MedicalRecordsScreen())
                           );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // 3. كارت الذكاء الاصطناعي (Healix AI)
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Ask Healix AI anything",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Get quick medical insights",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 15),
                      // زرار Ask
                      ElevatedButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.auto_awesome, size: 18, color: Colors.black),
                        label: const Text("Ask", style: TextStyle(color: Colors.black)),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.grey[200], // لون رصاصي فاتح
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                // 4. النشاطات الأخيرة (Recent Activity)
                Row(
                  children: [
                    const Icon(Icons.history, color: Colors.white),
                    const SizedBox(width: 10),
                    Text(
                      "Recent Activity",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontFamily: GoogleFonts.roboto().fontFamily,
                      ),
                    ),
                  ],
                ),
                
                const SizedBox(height: 15),

                // القائمة البيضاء الكبيرة بتاعت النشاطات
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      _buildActivityItem("Prescription added", "2 days ago", Icons.description),
                      const Divider(height: 30, color: Colors.grey), // خط فاصل
                      _buildActivityItem("Lab Test Result", "5 days ago", Icons.science),
                      const Divider(height: 30, color: Colors.grey),
                      _buildActivityItem("Appointment Confirmed", "1 week ago", Icons.check_circle_outline),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // --- دوال مساعدة (Helper Widgets) عشان الكود يبقى نظيف ---

  // 1. دالة بناء كارت الخدمة المربع (اللي فوق)
  Widget _buildQuickActionCard(String title, String imagePath, VoidCallback onTap) {
    return GestureDetector( // 1. ده اللي بيخلي الكونتينر يحس باللمس
      onTap: onTap, // 2. هنا بننفذ الأمر اللي جاي للدالة
      child: Container(
        width: 130,
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              imagePath,
              width: 50,
              height: 50,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 2. دالة بناء عنصر النشاط (Activity Item)
  Widget _buildActivityItem(String title, String date, IconData icon) {
    return Row(
      children: [
        // دائرة رصاصي مكان الصورة
        Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: Colors.grey[600]),
        ),
        const SizedBox(width: 15),
        // الكلام
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 5),
            Text(
              date,
              style: TextStyle(color: Colors.grey[500], fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }
}