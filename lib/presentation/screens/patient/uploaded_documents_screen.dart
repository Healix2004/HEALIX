import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';

// موديل المستند
class DocumentModel {
  final String title;
  final String type; // pdf, jpg, docx
  final String size;
  final String date;
  final bool isNew; // للتصنيف (Recent/Older)

  DocumentModel({required this.title, required this.type, required this.size, required this.date, required this.isNew});
}

class UploadedDocumentsScreen extends StatefulWidget {
  const UploadedDocumentsScreen({super.key});

  @override
  State<UploadedDocumentsScreen> createState() => _UploadedDocumentsScreenState();
}

class _UploadedDocumentsScreenState extends State<UploadedDocumentsScreen> {
  String selectedFilter = "All";
  String searchQuery = "";

  // بيانات وهمية
  final List<DocumentModel> allDocs = [
    DocumentModel(title: "Blood Test Report", type: "pdf", size: "1.2 MB", date: "Uploaded 3 days ago", isNew: true),
    DocumentModel(title: "X-Ray of Right Arm", type: "jpg", size: "4.5 MB", date: "Uploaded 1 week ago", isNew: true),
    DocumentModel(title: "Annual Checkup Notes", type: "docx", size: "256 KB", date: "Uploaded Dec 5, 2023", isNew: false),
    DocumentModel(title: "Insurance Documents", type: "zip", size: "10.1 MB", date: "Uploaded Nov 21, 2023", isNew: false),
    DocumentModel(title: "Old MRI Scan", type: "jpg", size: "15 MB", date: "Uploaded Jan 10, 2023", isNew: false),
  ];

  // فلترة
  List<DocumentModel> get filteredList {
    return allDocs.where((item) {
      final matchSearch = item.title.toLowerCase().contains(searchQuery.toLowerCase());
      // هنا ممكن نضيف لوجيك الفلتر حسب النوع لو حبيت
      return matchSearch; 
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // الزرار العائم لرفع ملف جديد
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          // كود رفع الملف
          print("Upload new document");
        },
        backgroundColor: Colors.white,
        icon: const Icon(Icons.add, color: Colors.black),
        label: const Text("Upload New Document", style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold)),
      ),
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
                        "Uploaded Documents",
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
                    hintText: "Search by document name",
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
                    _buildFilterChip("pdf"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Images"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Lab Reports"),
                    const SizedBox(width: 10),
                    _buildFilterChip("Radiology"),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // القائمة
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  children: [
                    // قسم المستندات الحديثة
                    if (filteredList.any((i) => i.isNew)) ...[
                      const Text("Recent Documents", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                      const SizedBox(height: 10),
                      ...filteredList.where((i) => i.isNew).map((e) => _buildDocCard(e)),
                      const SizedBox(height: 20),
                    ],

                    // قسم المستندات القديمة
                    if (filteredList.any((i) => !i.isNew)) ...[
                      const Text("Older Documents", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black54)),
                      const SizedBox(height: 10),
                      ...filteredList.where((i) => !i.isNew).map((e) => _buildDocCard(e)),
                    ],
                    
                    // مسافة عشان الزرار العائم مايغطيش آخر عنصر
                    const SizedBox(height: 80), 
                  ],
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

  Widget _buildDocCard(DocumentModel item) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          // أيقونة القلب (المفضلة)
          const Icon(Icons.favorite_border, color: Colors.black87),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15)),
                const SizedBox(height: 4),
                Text("${item.type.toUpperCase()} ${item.size}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                Text(item.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
              ],
            ),
          ),
          const Icon(Icons.arrow_forward_ios, size: 16, color: Colors.grey),
        ],
      ),
    );
  }
}