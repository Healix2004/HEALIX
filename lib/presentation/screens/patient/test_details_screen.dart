import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

class TestDetailsScreen extends StatelessWidget {
  // ممكن نمرر بيانات التحليل هنا في المستقبل
  final String testTitle;
  final String date;

  const TestDetailsScreen({
    super.key, 
    this.testTitle = "CBC Blood Test", // قيمة افتراضية حالياً
    this.date = "2 days ago",
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: AppColors.getHealixGradient(), // الخلفية الثابتة
        child: SafeArea(
          child: Column(
            children: [
              // 1. الهيدر (زرار الرجوع + العنوان + زرار المشاركة)
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
                        "Test Details",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                    // زرار المشاركة (Share)
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

              // 2. محتوى الصفحة القابل للتمرير
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // --- كارت ملخص التحليل ---
                      _buildSummaryCard(),
                      
                      const SizedBox(height: 25),

                      // --- قسم نتائج المعمل (Lab Results) ---
                      _buildSectionTitle("Lab Results"),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 15),
                        child: Column(
                          children: [
                            // عناوين الجدول
                            _buildResultRow("Parameter", "Result", "Normal Range", isHeader: true),
                            const Divider(color: Colors.grey),
                            // البيانات
                            _buildResultRow("Hemoglobin", "13.2 g/dL", "12-16 g/dL"),
                            _buildResultRow("WBC", "5.9 K/uL", "4-11 K/uL"),
                            // صف فيه مشكلة (Highligted Row)
                            _buildResultRow("Platelets", "250 k/uL", "150-450 K/uL", isAbnormal: true),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // --- قسم ملاحظات الطبيب ---
                      _buildSectionTitle("Doctor Comments"),
                      const SizedBox(height: 10),
                      Container(
                        width: double.infinity,
                        height: 100, // ارتفاع ثابت للملاحظات
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: const Text(
                          "Patient needs to improve hydration. Re-test in 3 months.", // نص افتراضي
                          style: TextStyle(color: Colors.black87),
                        ),
                      ),

                      const SizedBox(height: 25),

                      // --- قسم المرفقات (Attachments) ---
                      _buildSectionTitle("Attachments"),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Row(
                          children: [
                            // أيقونة الملف (PDF)
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Icon(Icons.picture_as_pdf, color: Colors.black87),
                            ),
                            const SizedBox(width: 15),
                            const Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Official_Report.pdf",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                                SizedBox(height: 5),
                                Text(
                                  "1.2 MB",
                                  style: TextStyle(color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.download_rounded, color: Colors.black54),
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

  // --- 1. تصميم كارت الملخص العلوي ---
  Widget _buildSummaryCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start, // عشان المحاذاة تبقى لفوق
        children: [
          // أيقونة التحليل الكبيرة
          const Icon(Icons.science, size: 40, color: Colors.black87),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      testTitle,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    // بادج الحالة (Completed)
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: Colors.green.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text(
                        "completed",
                        style: TextStyle(
                          color: Colors.green,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text("uploaded $date", style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 5),
                const Text("Requested by Dr.Adam", style: TextStyle(color: Colors.grey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // --- 2. عنوان القسم ---
  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: const Color(0xFF1A1A1A).withOpacity(0.7), // لون غامق هادي
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    );
  }

  // --- 3. تصميم صف الجدول (الذكي) ---
  Widget _buildResultRow(String param, String result, String range, {bool isHeader = false, bool isAbnormal = false}) {
    return Container(
      // لو الصف غير طبيعي (isAbnormal) بنديله لون خلفية أحمر فاتح
      color: isAbnormal ? const Color(0xFFFFEAEA) : Colors.transparent, 
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // العمود الأول: Parameter
          Expanded(
            flex: 2,
            child: Text(
              param,
              style: TextStyle(
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                color: isHeader ? Colors.black : Colors.black87,
              ),
            ),
          ),
          // العمود الثاني: Result
          Expanded(
            flex: 2,
            child: Center(
              child: Text(
                result,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          // العمود الثالث: Normal Range
          Expanded(
            flex: 2,
            child: Align(
              alignment: Alignment.centerRight,
              child: Text(
                range,
                style: TextStyle(
                  fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}