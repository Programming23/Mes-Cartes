// استيراد المكتبات اللازمة
import 'package:flashcards/model.dart';
import 'package:flutter/material.dart';

import '../constants/texts.dart';

// إنشاء الـ Body الخاص بعرض المجموعات
class FlashCardSetsBody extends StatelessWidget {
  final flashcardSets; // قائمة المجموعات
  final removeFlashCardSet;

  // الكونستراكتور الخاص بالـ Body
  const FlashCardSetsBody({
    super.key,
    required this.flashcardSets,
    required this.removeFlashCardSet,
  });

  // بناء الـ Body
  @override
  Widget build(BuildContext context) {
    // التحقق من وجود المجموعات
    if (flashcardSets == null) {
      // إذا لم يتم تحميل المجموعات بعد، تظهر دائرة التحميل
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (flashcardSets.length == 0) {
      // إذا لم يكن هناك أي مجموعات، تظهر رسالة خاصة بالتأكيد على ذلك
      return Center(
        child: Text(noFlashCardSetsMessage),
      );
    } else {
      // عرض المجموعات الموجودة باستخدام ListView.builder
      return ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 10),
        itemCount: flashcardSets.length,
        itemBuilder: (context, ind) {
          int index = flashcardSets.length - 1 - ind;
          // بناء بطاقة مخصصة لكل مجموعة، وعرض عنوان وفئة المجموعة
          return Dismissible(
            direction: DismissDirection.endToStart,
            key: ValueKey<int>(flashcardSets[index].id),
            background: Container(
              color: Colors.red.shade300,
              alignment: Alignment.centerRight,
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Icon(
                Icons.delete,
                color: Colors.white,
              ),
            ),
            onDismissed: (direction) {
              removeFlashCardSet(flashcardSets[index] as FlashcardSet);
            },
            child: Directionality(
              textDirection: TextDirection.rtl,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0.5,
                      blurRadius: 3,
                      offset: Offset(0, 1),
                    ),
                  ],
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                child: InkWell(
                  onTap: () {
                    // الانتقال إلى الشاشة الخاصة بدراسة المجموعة المحددة
                    Navigator.pushNamed(
                      context,
                      '/flashcard_set',
                      arguments: [flashcardSets[index], index],
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          flashcardSets[index].title, // عرض عنوان المجموعة
                          style: Theme.of(context)
                              .textTheme
                              .titleMedium, // تطبيق نمط العنوان للنص
                        ),
                        SizedBox(height: 5),
                        Text(
                          flashcardSets[index].category, // عرض فئة المجموعة
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall, // تطبيق نمط النص العادي للفئة
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      );
    }
    ;
  }
}
