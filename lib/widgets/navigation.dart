// هذا الكلاس يعمل على عرض شريط التنقل السفلي للتطبيق
// يستقبل معلومات currentIndex و changeIndex لتحديد الصفحة وتغييرها عند النقر على صفحة مختلفة

// يعرض هذا الكلاس شريط التنقل السفلي للتطبيق.

// يستقبل معلومات currentIndex و changeIndex لتحديد الصفحة وتغييرها عند النقر على صفحة مختلفة.

// يحتوي على BottomNavigationBar الذي يتم تعريفه بعدة خصائص وعناصر.

// يتم تحديد نوع الشريط باستخدام خاصية BottomNavigationBarType.fixed.

// يتم تحديد الصفحة الحالية في الشريط باستخدام currentIndex.

// يتم استجابة للنقر على العنصر باستخدام onTap.

// يتم تحديد الصفحة المطلوبة وتغيير الصفحة في حالة النقر على صفحة مختلفة.

// يتم عرض عناصر الشريط في قائمة BottomNavigationBarItem.

import 'package:flutter/material.dart';
import '/constants/texts.dart';
import '/screens/about_us.dart';

class BottomNavigation extends StatelessWidget {
  final currentIndex;
  final changeIndex;
  const BottomNavigation({
    super.key,
    required this.currentIndex,
    required this.changeIndex,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BottomNavigationBar(
        // نوع الشريط
        type: BottomNavigationBarType.fixed,
        // الصفحة الحالية في الشريط
        currentIndex: currentIndex,

        elevation: 100,
        onTap: (value) {
          // استجابة للنقر على العنصر
          if (value != currentIndex) {
            // تغيير الصفحة
            changeIndex(value);
            // تحديد الصفحة المطلوبة
            if (value == 0) {
              // الذهاب الى الصفحة الرئيسية
              Navigator.pushReplacementNamed(context, '/home');
            } else if (value == 1) {
              // الذهاب الى صفحة حولنا
              Navigator.pushReplacementNamed(context, '/about_us');
            }
          }
        },
        // عناصر الشريط
        items: [
          BottomNavigationBarItem(
            label: first_nav,
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: last_nav,
            icon: Icon(Icons.info),
          ),
        ],
      ),
    );
  }
}
