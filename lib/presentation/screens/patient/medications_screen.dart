import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

// موديل الدواء
class MedicationModel {
  final String name;
  final String type; // e.g., Blood Pressure Medication
  final String doctorName;
  final String dateRange;
  final String status; // Active, Completed, Stopped
  final String frequency;
  final String notes;

  MedicationModel({
    required this.name,
    required this.type,
    required this.doctorName,
    required this.dateRange,
    required this.status,
    required this.frequency,
    required this.notes,
  });
}

class MedicationsScreen extends StatefulWidget {
  const MedicationsScreen({super.key});

  @override
  State<MedicationsScreen> createState() => _MedicationsScreenState();
}

class _MedicationsScreenState extends State<MedicationsScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  // البيانات الوهمية
  final List<MedicationModel> allMedications = [
    MedicationModel(
      name: "Amlodipine 10 mg",
      type: "Blood Pressure Medication",
      doctorName: "Dr. Adam Smith",
      dateRange: "Jan 2023 - present",
      status: "Active",
      frequency: "Once daily",
      notes: "Take after meals",
    ),
    MedicationModel(
      name: "Ibuprofen 400 mg",
      type: "Pain Reliever",
      doctorName: "Dr. Sarah Jones",
      dateRange: "Jan 2023 - Feb 2023",
      status: "Completed",
      frequency: "Twice daily",
      notes: "Take when needed",
    ),
    MedicationModel(
      name: "Panadol Extra",
      type: "Pain Reliever",
      doctorName: "Dr. Adam Smith",
      dateRange: "Mar 2023",
      status: "Stopped",
      frequency: "Three times daily",
      notes: "Caused dizziness",
    ),
     MedicationModel(
      name: "Amlodipine 10 mg",
      type: "Blood Pressure Medication",
      doctorName: "Dr. Adam Smith",
      dateRange: "Jan 2023 - present",
      status: "Active",
      frequency: "Once daily",
      notes: "Take after meals",
    ),
  ];

  // منطق الفلترة والبحث
  List<MedicationModel> get filteredList {
    return allMedications.where((item) {
      final matchFilter = selectedFilter == "All" || item.status == selectedFilter;
      final matchSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase());
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
              // الهيدر
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
                        "Medications",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white, fontFamily: GoogleFonts.roboto().fontFamily),
                      ),
                    ),
                    const SizedBox(width: 40),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // البحث
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextField(
                  onChanged: (val) => setState(() => searchQuery = val),
                  decoration: InputDecoration(
                    hintText: "Search by medication name",
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

              // الفلاتر
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _buildFilterChip("All"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Active"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Completed"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Stopped"),
                    const SizedBox(width: 10),
                    _buildFilterChip("By Doctor"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // العنوان
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Recent Medications",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: const Color(0xFF1A1A1A).withOpacity(0.7)),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // القائمة
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: filteredList.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    return _buildMedicationCard(filteredList[index]);
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

  Widget _buildMedicationCard(MedicationModel item) {
    Color statusColor;
    Color statusBg;
    
    switch (item.status) {
      case "Active": statusColor = Colors.green; statusBg = Colors.green.withOpacity(0.1); break;
      case "Completed": statusColor = Colors.grey; statusBg = Colors.grey.withOpacity(0.2); break;
      case "Stopped": statusColor = Colors.red; statusBg = Colors.red.withOpacity(0.1); break;
      default: statusColor = Colors.blue; statusBg = Colors.blue.withOpacity(0.1);
    }

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.medication_outlined, size: 28, color: Colors.black87),
              const SizedBox(width: 15),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(item.type, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 5),
                    Text("by ${item.doctorName}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                    Text(item.dateRange, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(color: statusBg, borderRadius: BorderRadius.circular(20)),
                child: Text(item.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 15),
          const Divider(),
          const SizedBox(height: 10),
          Row(
            children: [
              Text("Frequency: ", style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold)),
              Text(item.frequency, style: TextStyle(color: Colors.grey[800], fontSize: 12)),
              const SizedBox(width: 15),
              Text("Notes: ", style: TextStyle(color: Colors.grey[600], fontSize: 12, fontWeight: FontWeight.bold)),
              Expanded(child: Text(item.notes, style: TextStyle(color: Colors.grey[800], fontSize: 12), overflow: TextOverflow.ellipsis)),
            ],
          ),
        ],
      ),
    );
  }
}