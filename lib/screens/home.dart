import 'package:flashcards/widgets/navigation.dart';

import '../model.dart';
import '/screens/search.dart';
import '/widgets/body_sets.dart';
import 'package:flutter/material.dart';
import '../constants/texts.dart';

class HomePage extends StatelessWidget {
  final List<FlashcardSet>?
      flashcardSets; // قائمة بمجموعات البطاقات الفلاش الموجودة
  final removeFlashCardSet; // دالة لحذف مجموعة بطاقات فلاش
  final currentIndex; // الفهرس الحالي لعرض مجموعات البطاقات الفلاش
  final changeIndex; // دالة لتغيير الفهرس لعرض مجموعة بطاقات فلاش أخرى

  HomePage({
    required this.flashcardSets,
    required this.removeFlashCardSet,
    required this.changeIndex,
    required this.currentIndex,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title), // عنوان الصفحة الرئيسية
        centerTitle: true, // مركز العنوان
        elevation: 0, // إزالة ظل الشريط العلوي للتطبيق
        actions: [
          // الأيقونات الموجودة في الشريط العلوي للتطبيق
          IconButton(
            icon: Icon(Icons.search), // أيقونة البحث
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/search',
              );
            },
          )
        ],
      ),
      bottomNavigationBar: BottomNavigation(
          currentIndex: currentIndex,
          changeIndex:
              changeIndex), // شريط الأسفل الذي يحتوي على الفهارس لعرض مجموعات البطاقات الفلاش
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, '/add_flashcardSet',
              arguments: ['add']); // زر الإضافة لإضافة مجموعة بطاقات فلاش جديدة
        },
        child: Icon(Icons.add), // أيقونة الزائدة
      ),
      body: FlashCardSetsBody(
        removeFlashCardSet: removeFlashCardSet,
        flashcardSets:
            flashcardSets, // عرض جميع مجموعات البطاقات الفلاش الموجودة
      ),
    );
  }
}
