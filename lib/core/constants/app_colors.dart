import 'package:flutter/material.dart';

class AppColors {
  // الألوان الأساسية المستخرجة من الفيجما (Healix Gradient)
  static const Color gradientStart = Color(0xFF54DEF9); // لبني فاتح
  static const Color gradientMid1 = Color(0xFF00B4D8);  // أزرق سماوي
  static const Color gradientMid2 = Color(0xFF0092E9);  // أزرق متوسط
  static const Color gradientEnd = Color(0xFF0450C1);   // أزرق غامق

  // ألوان النصوص والخلفيات الأخرى (توقع مبدئي لحد ما نحددها بدقة)
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color textGrey = Color(0xFF888888); 

  // دالة التدرج اللوني
  static BoxDecoration getHealixGradient() {
    return const BoxDecoration(
      gradient: RadialGradient(
        center: Alignment.topLeft,
        radius: 1.5,
        colors: [
          gradientStart,
          gradientMid1,
          gradientMid2,
          gradientEnd,
        ],
        stops: [0.06, 0.47, 0.81, 0.95],
      ),
    );
  }
} 
