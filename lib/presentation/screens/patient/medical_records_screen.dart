import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'lab_tests_screen.dart'; 
import '../patient/radiology_screen.dart';
import 'diagnoses_screen.dart';
import '../patient/doctor_notes_screen.dart';
import 'medications_screen.dart';
import 'uploaded_documents_screen.dart';

class MedicalRecordsScreen extends StatefulWidget {
  const MedicalRecordsScreen({super.key});

  @override
  State<MedicalRecordsScreen> createState() => _MedicalRecordsScreenState();
}

class _MedicalRecordsScreenState extends State<MedicalRecordsScreen> {
  String searchQuery = ""; // متغير البحث

  // 1. قائمة الخدمات (الأزرار الكبيرة)
  // حطينا الـ onTap جوه الليست عشان كل زرار يعرف يروح فين
  late List<Map<String, dynamic>> menuItems;

  // 2. قائمة التحديثات الأخيرة (Recent Updates)
  final List<Map<String, dynamic>> recentUpdates = [
    {"title": "CBC Blood Test", "date": "2 days ago", "icon": Icons.science},
    {"title": "Chest X-Ray", "date": "1 month ago", "icon": Icons.photo_size_select_actual_outlined},
    {"title": "Prescription Updated", "date": "last week", "icon": Icons.edit_note},
    {"title": "Vitamin D Check", "date": "3 months ago", "icon": Icons.wb_sunny_outlined},
  ];

  @override
  void initState() {
    super.initState();
    // تعريف قائمة الخدمات (لازم جوه initState عشان نقدر نستخدم context)
    menuItems = [
      {
        "title": "Lab Tests",
        "icon": Icons.science_outlined,
        "onTap": () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => const LabTestsScreen()));
        }
      },
      {
        "title": "Radiology",
        "icon": Icons.medical_services_outlined,
        "onTap":() {
    // التعديل هنا: الربط بالشاشة الجديدة
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  RadiologyScreen()),);
         }
      },
      {
        "title": "Diagnoses",
        "icon": Icons.assignment_outlined,
        "onTap": () {Navigator.push(context, MaterialPageRoute(builder: (context) => const DiagnosesScreen()));}
      },
      {
        "title": "Doctor Notes",
        "icon": Icons.description_outlined,
        "onTap": () {Navigator.push(context, MaterialPageRoute(builder: (context) => const DoctorNotesScreen()));}
      },
      {
        "title": "Medication History",
        "icon": Icons.medication_outlined,
        "onTap": () {Navigator.push(context, MaterialPageRoute(builder: (context) => const MedicationsScreen()));}
      },
      {
        "title": "Uploaded Documents",
        "icon": Icons.upload_file_outlined,
        "onTap": () {Navigator.push(context, MaterialPageRoute(builder: (context) => const UploadedDocumentsScreen()));}
      },
    ];
  }

  @override
  Widget build(BuildContext context) {
    // 3. منطق الفلترة (بنفلتر القائمتين بناءً على البحث)
    final filteredMenu = menuItems.where((item) => 
      item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

    final filteredUpdates = recentUpdates.where((item) => 
      item["title"].toString().toLowerCase().contains(searchQuery.toLowerCase())
    ).toList();

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
                        "Medical Records",
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

              // جسم الصفحة (قابل للسكرول)
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // كارت البروفايل
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundImage: AssetImage('assets/images/logo.png'),
                            ),
                            const SizedBox(width: 15),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Maryam Alrefaay",
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, fontFamily: GoogleFonts.roboto().fontFamily),
                                ),
                                const Text("ID: 23456789", style: TextStyle(color: Colors.grey, fontSize: 12)),
                              ],
                            ),
                            const Spacer(),
                            const Icon(Icons.settings_outlined, color: Colors.black54),
                          ],
                        ),
                      ),

                      const SizedBox(height: 20),

                      // --- شريط البحث الفعال ---
                      TextField(
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value; // تحديث النتائج فوراً
                          });
                        },
                        decoration: InputDecoration(
                          hintText: "Search your medical history",
                          hintStyle: const TextStyle(color: Colors.white70),
                          prefixIcon: const Icon(Icons.search, color: Colors.white70),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.2),
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(15), borderSide: BorderSide.none),
                          contentPadding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        style: const TextStyle(color: Colors.white),
                      ),

                      const SizedBox(height: 25),

                      // --- عرض القوائم المفلترة ---
                      
                      // 1. عرض الأقسام (Menu Buttons)
                      if (filteredMenu.isNotEmpty) ...[
                        ListView.separated(
                          shrinkWrap: true, // عشان تشتغل جوه SingleChildScrollView
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredMenu.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            return _buildMenuButton(
                              filteredMenu[index]["title"],
                              filteredMenu[index]["icon"],
                              filteredMenu[index]["onTap"],
                            );
                          },
                        ),
                        const SizedBox(height: 30),
                      ],

                      // 2. عرض التحديثات (Recent Updates)
                      // العنوان والفلاتر بيظهروا بس لو مفيش بحث أو لو لسه فيه نتايج
                      if (searchQuery.isEmpty || filteredUpdates.isNotEmpty) ...[
                         Text(
                          "Recent Updates",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            fontFamily: GoogleFonts.roboto().fontFamily,
                          ),
                        ),
                        
                        const SizedBox(height: 15),

                        // الفلاتر (شكل بس حالياً)
                        Row(
                          children: [
                            _buildFilterChip("By Date", true),
                            const SizedBox(width: 10),
                            _buildFilterChip("By Provider", false),
                            const SizedBox(width: 10),
                            _buildFilterChip("By Type", false),
                          ],
                        ),

                        const SizedBox(height: 20),

                        // قائمة التحديثات المفلترة
                        ListView.separated(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: filteredUpdates.length,
                          separatorBuilder: (context, index) => const SizedBox(height: 10),
                          itemBuilder: (context, index) {
                            return _buildUpdateItem(
                              filteredUpdates[index]["title"],
                              filteredUpdates[index]["date"],
                              filteredUpdates[index]["icon"],
                              () { print("Open ${filteredUpdates[index]["title"]}"); },
                            );
                          },
                        ),
                      ],
                      
                      // رسالة لو مفيش نتايج خالص
                      if (filteredMenu.isEmpty && filteredUpdates.isEmpty)
                         const Center(
                           child: Padding(
                             padding: EdgeInsets.only(top: 20),
                             child: Text("No results found", style: TextStyle(color: Colors.white)),
                           ),
                         ),

                      const SizedBox(height: 40),
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

  // --- Widgets مساعدة ---
  Widget _buildMenuButton(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 24),
            const SizedBox(width: 15),
            Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.black87)),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildUpdateItem(String title, String date, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(15),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
        child: Row(
          children: [
            Icon(icon, color: Colors.black87, size: 28),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text(date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip(String label, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFF0056D2) : Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black87,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          fontSize: 13,
        ),
      ),
    );
  }
}