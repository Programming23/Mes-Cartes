import 'package:flutter/material.dart';
import '../constants/numbers.dart';
import '../constants/texts.dart';
import '/widgets/navigation.dart'; // استيراد عنصر واجهة المستخدم للتنقل
import '../widgets/about_us/list_tile.dart'; // هذا هو الملف الذي نستورد منه القائمات
import '../widgets/about_us/about_us_text.dart';

// إنشاء ودجت "AboutUs" والذي يرث من ودجت "StatelessWidget"
class AboutUs extends StatelessWidget {
  // تعريف الخصائص الخاصة بالفئة
  final currentIndex;
  final changeIndex;
  const AboutUs({
    super.key,
    required this.changeIndex,
    required this.currentIndex,
  });

  // بناء عنصر واجهة المستخدم
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // بناء بنية عنصر واجهة المستخدم
      body: AboutUsBody(),
      // بناء واجهة الشريط السفلي
      bottomNavigationBar: BottomNavigation(
        currentIndex: currentIndex,
        changeIndex: changeIndex,
      ),
    );
  }
}

class AboutUsBody extends StatelessWidget {
  const AboutUsBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
        textDirection: TextDirection.rtl,
        child: ListView(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          children: [
            // عنصر واجهة المستخدم يحتوي على صورة
            Image.asset(
              path_image_aboutUs, // المسار الخاص بالصورة
              width:
                  width_aboutUs_image, // عرض الصورة . يمكنك تغييره في ملف "constants/numbers.dart" و بالضبط في المتغير المسمى "width_aboutUs_image"
              height:
                  height_aboutUs_image, // طول الصورة . يمكنك تغييره في ملف "constants/numbers.dart" و بالضبط في المتغير المسمى "height_aboutUs_image"
            ),
            SizedBox(
              height: 20,
            ),
            // عنصر واجهة المستخدم يحتوي على نص
            Text(
              'من نحن؟',
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(
              height: 5,
            ),

            AboutUsText(), // هذا هو النص الخاص بفقرة "من نحن؟"
            SizedBox(
              height: 15,
            ),
            // القائمة الخاصة ب رقم الهاتف
            ListTileAboutUs(
              direction: TextDirection.ltr, // اتجاه النص
              icon: Icons.phone, // الايقونة
              value: phoneNumber, // رقم الهاتف
            ),
            // القائمة الخاصة ب البريد الالكتروني
            ListTileAboutUs(
              direction: TextDirection.rtl, // اتجاه النص
              icon: Icons.email, // الايقونة
              value: email, // البريد الالكتروني
            ),
            // القائمة الخاصة ب الموقع
            ListTileAboutUs(
              direction: TextDirection.rtl, // اتجاه النص
              icon: Icons.web_outlined, // الايقونة
              value: website_url, // الموقع
            ),
            ListTileAboutUs(
              direction: TextDirection.ltr, // اتجاه النص
              icon: Icons.info, // الايقونة
              value: version, // الاصدار
            ),
          ],
        ));
  }
}
