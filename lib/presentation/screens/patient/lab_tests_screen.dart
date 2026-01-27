import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../patient/test_details_screen.dart';

// 1. موديل (قالب) للبيانات عشان نعرف نصنفهم
class LabTestModel {
  final String title;
  final String date;
  final String status;
  final IconData icon;
  final String category; // ده اللي هنفلتر بناءً عليه

  LabTestModel({
    required this.title,
    required this.date,
    required this.status,
    required this.icon,
    required this.category,
  });
}

class LabTestsScreen extends StatefulWidget {
  const LabTestsScreen({super.key});

  @override
  State<LabTestsScreen> createState() => _LabTestsScreenState();
}

class _LabTestsScreenState extends State<LabTestsScreen> {
  String selectedFilter = "All";
  String searchQuery = ""; // 1. متغير جديد لحفظ نص البحث

  // قائمة البيانات (زي ما هي)
  final List<LabTestModel> allTests = [
    LabTestModel(title: "CBC Blood Test", date: "2 days ago", status: "Completed", icon: Icons.science, category: "Blood Tests"),
    LabTestModel(title: "Chest X-Ray", date: "1 month ago", status: "Pending", icon: Icons.photo_size_select_actual_outlined, category: "Imaging-related labs"),
    LabTestModel(title: "Vitamin D Test", date: "3 months ago", status: "Completed", icon: Icons.wb_sunny_outlined, category: "Vitamins"),
    LabTestModel(title: "Urinalysis", date: "1 week ago", status: "Processing", icon: Icons.opacity, category: "Urine Tests"),
    LabTestModel(title: "CBC Blood Test", date: "5 months ago", status: "Completed", icon: Icons.science, category: "Blood Tests"),
    LabTestModel(title: "Thyroid Profile", date: "Yesterday", status: "Pending", icon: Icons.thermostat, category: "Hormones"),
    LabTestModel(title: "Chest X-Ray", date: "Last Year", status: "Completed", icon: Icons.photo_size_select_actual_outlined, category: "Imaging-related labs"),
  ];

  // 2. تحديث منطق الفلترة (الأهم)
  List<LabTestModel> get filteredTests {
    return allTests.where((test) {
      // الشرط الأول: هل القسم مطابق؟
      final matchCategory = selectedFilter == "All" || test.category == selectedFilter;
      
      // الشرط الثاني: هل الاسم يحتوي على نص البحث؟ (تحويل الكل لحروف صغيرة للمقارنة)
      final matchSearch = test.title.toLowerCase().contains(searchQuery.toLowerCase());

      // لازم الشرطين يتحققوا سوا
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
              // الهيدر (زي ما هو)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Lab Tests",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white,
                          fontFamily: GoogleFonts.roboto().fontFamily,
                        ),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // 3. ربط خانة البحث (TextField Update)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  // هنا التغيير: كل حرف تكتبه يحدث الشاشة
                  onChanged: (value) {
                    setState(() {
                      searchQuery = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: "Search your lab tests",
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

              // الفلاتر (زي ما هي)
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip("All"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Blood Tests"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Hormones"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Urine Tests"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Vitamins"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Imaging-related labs"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // القائمة
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredTests.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final test = filteredTests[index];
                    return _buildTestCard(
                      title: test.title,
                      date: test.date,
                      status: test.status,
                      icon: test.icon,
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

  // الدوال المساعدة (زي ما هي بالظبط بدون تغيير)
  Widget _buildFilterChip(String label) {
    bool isSelected = selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedFilter = label;
        });
      },
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

  Widget _buildTestCard({required String title, required String date, required String status, required IconData icon}) {
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
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => const TestDetailsScreen(
        testTitle: "CBC Blood Test", // ممكن تمرر الاسم هنا
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