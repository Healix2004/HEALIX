import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
class RadiologyDetailsScreen extends StatelessWidget {
  final String title;
  final String date;

  const RadiologyDetailsScreen({
    super.key,
    this.title = "Chest X-Ray",
    this.date = "15-09-2023",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppColors.getHealixGradient(),
        child: SafeArea(
          child: Column(
            children: [
              // الهيدر
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: Colors.white24,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Radiology Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(Icons.ios_share, color: Colors.white, size: 24),
                    ),
                  ],
                ),
              ),

              // المحتوى
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildSummaryCard(),
                      const SizedBox(height: 25),

                      _buildSectionTitle("Images"),
                      const SizedBox(height: 10),
                      
                      // --- التصحيح هنا: استدعاء الدالة بشكل صحيح ---
                      Row(
                        children: [
                          _buildImagePlaceholder("assets/images/xray_placeholder_1.png"),
                          const SizedBox(width: 10),
                          _buildImagePlaceholder("assets/images/xray_placeholder_2.png"),
                        ],
                      ),
                      
                      const SizedBox(height: 25),

                      _buildSectionTitle("Clinical Impression"),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 100,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "Normal chest x-ray. No acute cardiopulmonary process.",
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),
                      const SizedBox(height: 25),

                      _buildSectionTitle("Key Findings"),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            _buildFindingRow(Icons.check_circle, Colors.green, "Finding 1: Clear lungs"),
                            const SizedBox(height: 10),
                            _buildFindingRow(Icons.error, Colors.amber, "Finding 2: Minor inflammation"),
                            const SizedBox(height: 10),
                            _buildFindingRow(Icons.check_circle, Colors.green, "Finding 3: Normal heart size"),
                          ],
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // --- الويدجت المساعدة ---

  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.photo_size_select_actual_outlined, size: 40, color: Colors.black87),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.blue[100],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text("ICT", style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold, fontSize: 10)),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text("Date: $date", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                const Text("Ordered by: Dr.xxxxxxxxx", style: TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                const Text("Performed at: xxxxxx Hospital", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A).withOpacity(0.7),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }

  // --- التصحيح هنا: حذف المسافة في اسم الدالة ---
  Widget _buildImagePlaceholder(String imagePath) {
    return Expanded(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Image.asset(
          imagePath,
          height: 120,
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              height: 120,
              color: Colors.grey[300],
              child: const Center(child: Icon(Icons.broken_image, color: Colors.grey)),
            );
          },
        ),
      ),
    );
  }

  Widget _buildFindingRow(IconData icon, Color color, String text) {
    return Row(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(width: 10),
        Text(text, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}