import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../core/constants/app_colors.dart';
import 'diagnoses_screen.dart'; // عشان نستورد الموديل

class DiagnosesDetailsScreen extends StatelessWidget {
  final DiagnosisModel model;

  const DiagnosesDetailsScreen({super.key, required this.model});

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
                        "Diagnoses details",
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

                      // 2. Overview
                      _buildSectionTitle("Condition Overview"),
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        width: double.infinity,
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                        child: const Text("Patient has a history of high blood pressure...", style: TextStyle(color: Colors.black54)),
                      ),

                      const SizedBox(height: 25),

                      // 3. Symptoms
                      _buildSectionTitle("Symptoms"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          _buildSymptomChip("Headache"),
                          const SizedBox(width: 10),
                          _buildSymptomChip("Fatigue"),
                          const SizedBox(width: 10),
                          _buildSymptomChip("Dizziness"),
                        ],
                      ),

                      const SizedBox(height: 25),

                      // 4. Treatment Plan (القائمة اللي في التصميم)
                      _buildSectionTitle("Treatment Plan"),
                      const SizedBox(height: 10),
                      _buildTreatmentItem(Icons.medication, "Amlodipine 10 mg Daily", "Medication"),
                      const SizedBox(height: 10),
                      _buildTreatmentItem(Icons.no_food, "Low-sodium Diet", "Lifestyle Change"),
                      const SizedBox(height: 10),
                      _buildTreatmentItem(Icons.directions_run, "Regular Exercise", "Lifestyle Change"),

                      const SizedBox(height: 25),

                      // 5. Doctor Comments
                      _buildSectionTitle("Doctor Comments"),
                      const SizedBox(height: 10),
                      Container(
                        height: 100,
                        width: double.infinity,
                        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(15)),
                      ),

                      const SizedBox(height: 25),

                      // 6. Attachments
                      _buildSectionTitle("Attachments"),
                      const SizedBox(height: 10),
                      Row(
                        children: [
                          Expanded(child: _buildAttachmentCard()),
                          const SizedBox(width: 15),
                          Expanded(child: _buildAttachmentCard()),
                        ],
                      ),
                      
                      const SizedBox(height: 20),
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
    Color statusColor = model.status == "Active" ? Colors.green : (model.status == "Critical" ? Colors.red : Colors.grey);
    
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
                decoration: BoxDecoration(color: statusColor.withOpacity(0.1), borderRadius: BorderRadius.circular(20)),
                child: Text(model.status, style: TextStyle(color: statusColor, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
            ],
          ),
          const Divider(height: 30),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Diagnosed", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(model.date, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text("Severity", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                  const SizedBox(height: 4),
                  Text(model.severity, style: const TextStyle(color: Colors.grey, fontSize: 12)),
                ],
              ),
            ],
          ),
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

  Widget _buildSymptomChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20)),
      child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
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