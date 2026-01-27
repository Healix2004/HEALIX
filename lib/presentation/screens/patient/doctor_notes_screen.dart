import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import '../patient/doctor_notes_details_screen.dart';
// 1. موديل بيانات الملاحظة
class DoctorNoteModel {
  final String title;
  final String doctorName;
  final String date;
  final String status; // Completed, Pending
  final IconData icon;

  DoctorNoteModel({
    required this.title,
    required this.doctorName,
    required this.date,
    required this.status,
    required this.icon,
  });
}

class DoctorNotesScreen extends StatefulWidget {
  const DoctorNotesScreen({super.key});

  @override
  State<DoctorNotesScreen> createState() => _DoctorNotesScreenState();
}

class _DoctorNotesScreenState extends State<DoctorNotesScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  // 2. البيانات الوهمية
  final List<DoctorNoteModel> allNotes = [
    DoctorNoteModel(
      title: "Routine Check-Up",
      doctorName: "Dr. Adam Smith",
      date: "15-09-2023",
      status: "Completed",
      icon: Icons.favorite_border,
    ),
    DoctorNoteModel(
      title: "Post-Surgery Follow-UP",
      doctorName: "Dr. Sarah Jones",
      date: "15-09-2023",
      status: "Completed",
      icon: Icons.medical_services_outlined,
    ),
    DoctorNoteModel(
      title: "Blood Test Review",
      doctorName: "Dr. Adam Smith",
      date: "10-08-2023",
      status: "Completed",
      icon: Icons.bloodtype_outlined,
    ),
    DoctorNoteModel(
      title: "Allergy Consultation",
      doctorName: "Dr. Emily White",
      date: "15-09-2023",
      status: "Pending",
      icon: Icons.medication_outlined,
    ),
  ];

  // منطق الفلترة
  List<DoctorNoteModel> get filteredList {
    return allNotes.where((item) {
      // فلترة بسيطة بالاسم
      final matchSearch = item.title.toLowerCase().contains(searchQuery.toLowerCase()) || 
                          item.doctorName.toLowerCase().contains(searchQuery.toLowerCase());
      return matchSearch;
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
                        "Doctor Notes",
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
                    hintText: "Search by doctor's name",
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

              // --- الفلاتر ---
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip("All"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Recent"),
                    const SizedBox(width: 10),
                    _buildFilterChip("By Doctor"),
                    const SizedBox(width: 10),
                    _buildFilterChip("By Date"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // --- القائمة ---
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    final item = filteredList[index];
                    return _buildNoteCard(item);
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

  Widget _buildNoteCard(DoctorNoteModel item) {
    return GestureDetector(
      onTap: () {
        // الانتقال لصفحة التفاصيل
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => DoctorNotesDetailsScreen(model: item)),
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
            Icon(item.icon, size: 28, color: Colors.black87),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                  const SizedBox(height: 4),
                  Text(item.doctorName, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  const SizedBox(height: 4),
                  Text(item.date, style: const TextStyle(color: Colors.grey, fontSize: 11)),
                ],
              ),
            ),
            const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}