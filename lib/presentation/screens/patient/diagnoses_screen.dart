import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../patient/diagnoses_details_screen.dart';
// 1. موديل البيانات (يجمع كل تفاصيل التشخيص)
class DiagnosisModel {
  final String title;
  final String description;
  final String date;
  final String status; // Active, Resolved, Critical
  final String severity; // Moderate, High, Low
  final IconData icon;

  DiagnosisModel({
    required this.title,
    required this.description,
    required this.date,
    required this.status,
    required this.severity,
    required this.icon,
  });
}

class DiagnosesScreen extends StatefulWidget {
  const DiagnosesScreen({super.key});

  @override
  State<DiagnosesScreen> createState() => _DiagnosesScreenState();
}

class _DiagnosesScreenState extends State<DiagnosesScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  // 2. البيانات الوهمية
  final List<DiagnosisModel> allDiagnoses = [
    DiagnosisModel(
      title: "Hypertension",
      description: "High blood pressure, chronic condition.",
      date: "15-09-2023",
      status: "Active",
      severity: "Moderate",
      icon: Icons.favorite_border,
    ),
    DiagnosisModel(
      title: "Acute Bronchitis",
      description: "Chronic metabolic disorder.",
      date: "20-07-2023",
      status: "Resolved",
      severity: "Low",
      icon: Icons.calendar_today_outlined, // أيقونة معبرة
    ),
    DiagnosisModel(
      title: "Asthma",
      description: "Chronic metabolic disorder.",
      date: "20-07-2023",
      status: "Critical",
      severity: "High",
      icon: Icons.medication_outlined,
    ),
    DiagnosisModel(
      title: "Type 2 Diabetes",
      description: "Chronic metabolic disorder.",
      date: "20-07-2023",
      status: "Active",
      severity: "Moderate",
      icon: Icons.bloodtype_outlined,
    ),
     DiagnosisModel(
      title: "Seasonal Allergies",
      description: "Allergic rhinitis.",
      date: "22-04-2023",
      status: "Resolved",
      severity: "Low",
      icon: Icons.grass,
    ),
  ];

  // منطق الفلترة والبحث
  List<DiagnosisModel> get filteredList {
    return allDiagnoses.where((item) {
      final matchFilter = selectedFilter == "All" || item.status == selectedFilter;
      final matchSearch = item.title.toLowerCase().contains(searchQuery.toLowerCase());
      return matchFilter && matchSearch;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
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
                        decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(10)),
                        child: const Icon(Icons.arrow_back_ios_new, color: Colors.white, size: 20),
                      ),
                    ),
                    Expanded(
                      child: Text(
                        "Diagnoses",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: GoogleFonts.roboto().fontFamily),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- البحث ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (val) => setState(() => searchQuery = val),
                  decoration: InputDecoration(
                    hintText: "Search diagnoses by name",
                    hintStyle: const TextStyle(color: Colors.white70),
                    prefixIcon: const Icon(Icons.search, color: Colors.white70),
                    suffixIcon: const Icon(Icons.filter_list, color: Colors.white70),
                    filled: true,
                    fillColor: Colors.white.withOpacity(0.2),
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                  ),
                  style: const TextStyle(color: Colors.white),
                ),
              ),

              const SizedBox(height: 20),

              // --- الفلاتر الأفقية ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip("All"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Active"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Resolved"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Critical"), // بدلت Chronic بـ Critical حسب الداتا
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- عنوان القائمة ---
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Diagnoses",
                    style: TextStyle(
                      fontSize: 18, 
                      fontWeight: FontWeight.bold, 
                      color: const Color(0xFF1A1A1A).withOpacity(0.7), // لون غامق شفاف شوية
                      fontFamily: GoogleFonts.roboto().fontFamily,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // --- القائمة ---
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return _buildDiagnosisCard(item);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

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
          style: TextStyle(color: isSelected ? Colors.white : Colors.black87, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }

  Widget _buildDiagnosisCard(DiagnosisModel item) {
    // تحديد الألوان حسب الحالة
    Color badgeColor;
    Color badgeBg;
    
    switch (item.status) {
      case "Active":
        badgeColor = Colors.green;
        badgeBg = Colors.green.withOpacity(0.1);
        break;
      case "Resolved":
        badgeColor = Colors.grey;
        badgeBg = Colors.grey.withOpacity(0.2);
        break;
      case "Critical":
        badgeColor = Colors.red;
        badgeBg = Colors.red.withOpacity(0.1);
        break;
      default:
        badgeColor = Colors.blue;
        badgeBg = Colors.blue.withOpacity(0.1);
    }

    return GestureDetector(
      onTap: () {
        // الانتقال لصفحة التفاصيل (هنعملها دلوقتي)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DiagnosesDetailsScreen(model: item)),
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
            // الأيقونة
            Icon(item.icon, size: 28, color: Colors.black87),
            const SizedBox(width: 15),
            
            // النصوص
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.description, style: const TextStyle(color: Colors.grey, fontSize: 12), maxLines: 1, overflow: TextOverflow.ellipsis),
                  const SizedBox(height: 4),
                  Text("Diagnosed : ${item.date}", style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),

            // البادج والسهم
            Column(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(color: badgeBg, borderRadius: BorderRadius.circular(20)),
                  child: Text(item.status, style: TextStyle(color: badgeColor, fontSize: 10, fontWeight: FontWeight.bold)),
                ),
                const SizedBox(height: 10),
                const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }
}