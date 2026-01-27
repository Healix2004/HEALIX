import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'radiology_details_screen.dart';

// 1. موديل بيانات الأشعة
class RadiologyModel {
  final String title;
  final String date;
  final String status;
  final IconData icon;
  final String category; // نوع الأشعة (X-Ray, MRI, etc.)

  RadiologyModel({
    required this.title,
    required this.date,
    required this.status,
    required this.icon,
    required this.category,
  });
}

class RadiologyScreen extends StatefulWidget {
  const RadiologyScreen({super.key});

  @override
  State<RadiologyScreen> createState() => _RadiologyScreenState();
}

class _RadiologyScreenState extends State<RadiologyScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  // 2. بيانات الأشعة (مبنية على الصورة اللي بعتها)
  final List<RadiologyModel> allScans = [
    RadiologyModel(
      title: "Chest X-Ray",
      date: "1 month ago",
      status: "Pending",
      icon: Icons.photo_size_select_actual_outlined, // أيقونة معبرة عن صورة الأشعة
      category: "X-Ray",
    ),
    RadiologyModel(
      title: "Cardiac Ultrasound",
      date: "2 days ago",
      status: "Completed",
      icon: Icons.favorite_border, // أيقونة القلب
      category: "Ultrasound",
    ),
    RadiologyModel(
      title: "Knee MRI",
      date: "last week",
      status: "Processing",
      icon: Icons.accessibility_new, // أيقونة تعبر عن العظام/الجسم
      category: "MRI",
    ),
    RadiologyModel(
      title: "Brain CT Scan",
      date: "3 months ago",
      status: "Completed",
      icon: Icons.psychology_outlined, // أيقونة المخ
      category: "CT Scan",
    ),
     RadiologyModel(
      title: "Chest X-Ray",
      date: "Yesterday",
      status: "Pending",
      icon: Icons.photo_size_select_actual_outlined,
      category: "X-Ray",
    ),
  ];

  // منطق الفلترة والبحث
  List<RadiologyModel> get filteredScans {
    return allScans.where((scan) {
      final matchCategory = selectedFilter == "All" || scan.category == selectedFilter;
      final matchSearch = scan.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchCategory && matchSearch;
    }).toList();
  }

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
              // --- الهيدر ---
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
                        "Radiology", // العنوان الجديد
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- شريط البحث ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (value) => setState(() => searchQuery = value),
                  decoration: InputDecoration(
                    hintText: "Search your radiology scans", // نص البحث الجديد
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    suffixIcon: const Icon(Icons.filter_list, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              // --- الفلاتر (حسب الصورة) ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip("All"),
                    const SizedBox(width: 10),
                    _buildFilterChip("X-Ray"),
                    const SizedBox(width: 10),
                    _buildFilterChip("MRI"),
                    const SizedBox(width: 10),
                    _buildFilterChip("CT Scan"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Ultrasound"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- القائمة ---
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredScans.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final scan = filteredScans[index];
                    return _buildScanCard(
                      title: scan.title,
                      date: scan.date,
                      status: scan.status,
                      icon: scan.icon,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // الويدجت المساعدة (نفس الستايل بالظبط)
  Widget _buildFilterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () => setState(() => selectedFilter = label),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF0056D2) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black87,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildScanCard({
    required String title,
    required String date,
    required String status,
    required IconData icon,
  }) {
    Color statusColor;
    Color statusBgColor;

    switch (status) {
      case "Completed":
        statusColor = Colors.green;
        statusBgColor = Colors.green.withOpacity(0.1);
        break;
      case "Pending":
        statusColor = Colors.orange;
        statusBgColor = Colors.orange.withOpacity(0.1);
        break;
      case "Processing":
        statusColor = Colors.blue;
        statusBgColor = Colors.blue.withOpacity(0.1);
        break;
      default:
        statusColor = Colors.grey;
        statusBgColor = Colors.grey.withOpacity(0.1);
    }

    return GestureDetector(
      onTap: () {
    // التعديل هنا: الانتقال لصفحة التفاصيل الجديدة
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RadiologyDetailsScreen(
          title: title, // بنمرر الاسم والتاريخ عشان يظهروا هناك
          date: date,
        ),
      ),
    );
  },
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, size: 30, color: Colors.black87),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 5),
                  Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(color: statusBgColor, borderRadius: BorderRadius.circular(10)),
              child: Text(status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 10)),
            ),
            const SizedBox(width: 10),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}