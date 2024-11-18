import 'dart:async';
import 'package:flutter/material.dart';
import '../constants/numbers.dart';
import '../constants/texts.dart';

// هذه هي اول صفحة تظهر للمستخدم و تسمى صفحة الانتظار . تدوم لمدة 3 ثواني . يمكنك تغيير المدة في ملف (constants/numbers.dart) و بالضبط المتغير المسمى "duration_loading_page"

class LoadingPage extends StatefulWidget {
  LoadingPage({super.key});

  @override
  State<LoadingPage> createState() => _LoadingPageState();
}

class _LoadingPageState extends State<LoadingPage> {
  @override
  void initState() {
    // بعد 3 ثواني او المدة التي حددتها سيتم نقل المستخدم الى الصفحة الرئيسية
    Timer(Duration(seconds: duration_loading_page), () {
      Navigator.pushReplacementNamed(context, '/home');
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.center, // نضع الصورة في الوسط
                    child: Image.asset(
                      path_image_loading, // المسار الخاص بالصورة
                      height:
                          width_loading_image, // عرض الصورة . يمكنك تغييره في ملف "constants/numbers.dart" و بالضبط في المتغير المسمى "width_loading_image"
                      width:
                          height_loading_image, // عرض الصورة . يمكنك تغييره في ملف "constants/numbers.dart" و بالضبط في المتغير المسمى "height_loading_image"
                    ),
                  ),
                  Container(
                    height: 25,
                  ),
                  Text(
                    title, // اسم التطبيق . يمكنك تغييره باتباع الخطوات الموضحة في التوثيق
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
