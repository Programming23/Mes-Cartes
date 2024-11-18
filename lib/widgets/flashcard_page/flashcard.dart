import 'package:flutter/material.dart';

import '../../constants/texts.dart';

class FlashCardWidget extends StatelessWidget {
  const FlashCardWidget({
    super.key,
    required this.flashCardSet,
    required this.index,
    required this.removeFlashCard,
  });
  final flashCardSet; // البيانات المستلمة من فئة FlashCardSet.
  final index; // مؤشر البطاقة الحالية.
  final removeFlashCard; // دالة لإزالة بطاقة الفلاش.

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6, // الرفعة.
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10), // شكل الزاوية للبطاقة.
      ),
      margin: EdgeInsets.symmetric(
          horizontal: 20, vertical: 40), // المسافة من الحواف.
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 5, vertical: 10), // التباعد بين الحواف والنص.
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // محاذاة النص على اليسار.
          children: [
            SizedBox(height: 10), // مسافة فارغة.
            PopupMenuButton(
              icon: Icon(
                Icons.adaptive.more, // رمز القائمة.
                color: Colors.black,
              ),
              elevation: 100, // الرفعة.
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      'تعديل', // اسم الخيار.
                      style:
                          Theme.of(context).textTheme.labelMedium, // نمط النص.
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      'حذف', // اسم الخيار.
                      style:
                          Theme.of(context).textTheme.labelMedium, // نمط النص.
                    ),
                  )
                ];
              },
              onSelected: ((value) {
                if (value == 0) {
                  Navigator.pushNamed(
                    context,
                    '/add_flashcard', // اسم الصفحة الجديدة.
                    arguments: [
                      'update',
                      flashCardSet.cards[index]
                    ], // المعطيات المرسلة.
                  );
                }
                if (value == 1) {
                  if (flashCardSet.cards.length == 1) {
                    Navigator.pop(context); // الرجوع للصفحة السابقة.
                  }
                  removeFlashCard(
                    flashCardSet.cards[index],
                  );
                  flashCardSet.cards.removeAt(index); // إزالة البطاقة الحالية.
                }
              }),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: 15, vertical: 10), // التباعد بين الحواف والنص.
              child: Column(
                crossAxisAlignment:
                    CrossAxisAlignment.start, // محاذاة النص على اليسار.
                children: [
                  Text(
                    front_label_text, // عنوان المنظر الأمامي.
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    flashCardSet.cards[index].front,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  SizedBox(height: 10),
                  Divider(
                    color: Colors.grey[400],
                    thickness: 1,
                  ),
                  SizedBox(height: 10),
                  Text(
                    back_label_text,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  SizedBox(height: 10),
                  Text(
                    flashCardSet.cards[index].back,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
