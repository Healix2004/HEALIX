import 'package:flutter/material.dart';

// 1. حولناها لـ StatefulWidget عشان نقدر نغير الحالة (إظهار/إخفاء)
class CustomTextField extends StatefulWidget {
  final String hintText;
  final bool isPassword; // هل الحقل ده باسورد؟
  final TextEditingController? controller;
  final IconData? suffixIcon; // أيقونة إضافية لو حبيت

  const CustomTextField({
    super.key,
    required this.hintText,
    this.isPassword = false, // القيمة الافتراضية فولس
    this.controller,
    this.suffixIcon,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  // متغير عشان نتابع حالة النص (مخفي ولا ظاهر)
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // بنخلي الحالة الأولية تعتمد على نوع الحقل
    // لو هو مش باسورد أصلاً، يبقى مفيش إخفاء
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      // هنا السحر: بنقوله خفي النص بناءً على المتغير ده
      obscureText: widget.isPassword ? _obscureText : false,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide.none,
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        
        // اللوجيك الخاص بالأيقونة
        suffixIcon: widget.isPassword
            ? IconButton(
                // لو هو باسورد، اعرض زرار العين
                icon: Icon(
                  // لو مخفي اعرض عين مقفولة، لو ظاهر اعرض عين مفتوحة
                  _obscureText ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                  color: Colors.grey,
                ),
                onPressed: () {
                  // لما يدوس، اعكس الحالة (من true لـ false والعكس)
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : (widget.suffixIcon != null 
                ? Icon(widget.suffixIcon, color: Colors.grey) 
                : null), // لو مش باسورد، اعرض الأيقونة العادية لو موجودة
      ),
    );
  }
}