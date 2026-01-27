import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'doctor_notes_screen.dart'; 

class DoctorNotesDetailsScreen extends StatelessWidget {
  final DoctorNoteModel model;

  const DoctorNotesDetailsScreen({super.key, required this.model});

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
                    const Icon(Icons.ios_share, color: Colors.white, size: 24),
                  ],
                ),
              ),

              // --- المحتوى ---
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 1. الكارت الرئيسي
                      _buildMainCard(),

                      const SizedBox(height: 25),

                      // 2. التشخيصات المرتبطة
                      _buildSectionTitle("Associated Diagnoses"),
                      const SizedBox(height: 10),
                      Container(
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          children: [
                            _buildDiagnosisRow("Hypertension", "Active", Colors.green),
                            const Divider(indent: 15, endIndent: 15),
                            _buildDiagnosisRow("Acute Bronchitis", "Resolved", Colors.grey),
                            const Divider(indent: 15, endIndent: 15),
                            _buildDiagnosisRow("Asthma", "Critical", Colors.red),
                          ],
                        ),
                      ),

                      const SizedBox(height: 25),

                      // 3. ملاحظات الطبيب
                      _buildSectionTitle("Doctor Notes"),
                      const SizedBox(height: 10),
                      Container(
                        height: 120,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: const Text("Patient showing good recovery signs...", style: TextStyle(color: Colors.black54)),
                      ),

                      const SizedBox(height: 25),

                      // 4. القياسات
                      _buildSectionTitle("Measurements"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildMeasurementCard("Blood Pressure", "120/180 mmHg")),
                          const SizedBox(width: 15),
                          Expanded(child: _buildMeasurementCard("Heart Rate", "72 bpm")),
                        ],
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          Expanded(child: _buildMeasurementCard("Weight", "72 Kg")),
                          const SizedBox(width: 15),
                          Expanded(child: _buildMeasurementCard("Temperature", "32 C")),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // 5. خطة العلاج
                      _buildSectionTitle("Treatment Plan"),
                      const SizedBox(height: 10),
                      _buildTreatmentItem(Icons.medication, "Amlodipine 10 mg Daily", "Medication"),
                      const SizedBox(height: 10),
                      _buildTreatmentItem(Icons.no_food, "Low-sodium Diet", "Lifestyle Change"),
                      
                      const SizedBox(height: 25),

                      // 6. المرفقات (Attachments) - الجزء الجديد المضاف ✅
                      _buildSectionTitle("Attachments"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildAttachmentCard()),
                          const SizedBox(width: 15),
                          Expanded(child: _buildAttachmentCard()),
                        ],
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

  // --- Widgets ---

  Widget _buildMainCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(model.title, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(color: Colors.green.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: const Text("Completed", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const SizedBox(height: 5),
          Text("${model.doctorName} at xxxxxx Hospital", style: const TextStyle(color: Colors.grey, fontSize: 12)),
          Text(model.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildDiagnosisRow(String title, String status, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      child: Row(
        children: [
          const Icon(Icons.assignment_outlined, size: 20, color: Colors.black87),
          const SizedBox(width: 10),
          Expanded(child: Text(title, style: const TextStyle(fontWeight: FontWeight.w600))),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(color: color.withOpacity(0.1), borderRadius: BorderRadius.circular(10)),
            child: Text(status, style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
          ),
          const SizedBox(width: 10),
          const Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildMeasurementCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          const SizedBox(height: 5),
          Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
        ],
      ),
    );
  }

  Widget _buildTreatmentItem(IconData icon, String title, String subtitle) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Colors.black87),
          const SizedBox(width: 15),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
              Text(subtitle, style: const TextStyle(color: Colors.grey, fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  // Widget المرفقات الجديد ✅
  Widget _buildAttachmentCard() {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
      child: const Column(
        children: [
          Icon(Icons.picture_as_pdf, size: 30, color: Colors.black87),
          SizedBox(height: 10),
          Text("Official_Report.pdf", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12), textAlign: TextAlign.center),
          Text("1.2 MB", style: TextStyle(color: Colors.grey, fontSize: 10)),
          SizedBox(height: 10),
          Icon(Icons.download, size: 18, color: Colors.black54),
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
}