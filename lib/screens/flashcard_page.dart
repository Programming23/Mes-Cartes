import 'package:flashcards/constants/texts.dart';
import 'package:flutter/material.dart';

import '../widgets/flashcard_page/flashcard.dart';

class FlashcardSetScreen extends StatefulWidget {
  final flashcardSet;
  final index;
  final removeFlashCard;
  final removeFlashCardSet;

  FlashcardSetScreen({
    required this.flashcardSet,
    required this.index,
    required this.removeFlashCard,
    required this.removeFlashCardSet,
  });

  @override
  _FlashcardSetScreenState createState() => _FlashcardSetScreenState();
}

class _FlashcardSetScreenState extends State<FlashcardSetScreen> {
  late PageController
      pageController; // يتم تعريف الكونترولر الذي يتحكم بعدد الصفحات والصفحة الحالية
  int currentScreen = 0; // تعريف الصفحة الحالية

  @override
  void initState() {
    pageController = PageController(); // تعريف الكونترولر لتحكم بعدد الصفحات
    super.initState(); // يتم تنفيذ العمليات الأساسية للكلاس
  }

  goNextPage() {
    // دالة للانتقال إلى الكارت التالي أو الأول إذا كان على آخر كارت
    if (pageController.page ==
        widget.flashcardSet.cards.length.toDouble() - 1) {
      setState(() {
        pageController.animateToPage(
          0,
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
        );
      });
    } else {
      setState(() {
        pageController.nextPage(
          curve: Curves.ease,
          duration: Duration(milliseconds: 500),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl, // تعديل اتجاه النص إلى اليمين
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.flashcardSet.title), // إضافة عنوان الشاشة
          centerTitle: true, // وسط العنوان
          elevation: 0, // إزالة الظل
          actions: [
            PopupMenuButton(
              icon: Icon(
                Icons.adaptive.more,
                color: Colors.white,
              ),
              elevation: 100,
              itemBuilder: (context) {
                return [
                  PopupMenuItem<int>(
                    value: 0,
                    child: Text(
                      'تعديل',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  ),
                  PopupMenuItem<int>(
                    value: 1,
                    child: Text(
                      'حذف',
                      style: Theme.of(context).textTheme.labelMedium,
                    ),
                  )
                ];
              },
              onSelected: ((value) {
                if (value == 0) {
                  Navigator.pushNamed(context, '/add_flashcardSet', arguments: [
                    'update',
                    widget.flashcardSet,
                  ]);
                } else if (value == 1) {
                  Navigator.pop(context);
                  widget.removeFlashCardSet(
                    widget.flashcardSet,
                  );
                }
              }),
            )
          ],
        ),
        floatingActionButton: Container(
          padding: EdgeInsets.symmetric(horizontal: 30),
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(
                context,
                '/add_flashcard',
                arguments: ['add', widget.flashcardSet],
              );
            },
            child: Icon(Icons.add),
          ),
        ),
        body: PageView.builder(
          controller: pageController,
          physics: ClampingScrollPhysics(),
          itemCount:
              widget.flashcardSet.cards.length, // عدد الصفحات يساوي عدد الكروت
          itemBuilder: (context, index) {
            return ListView(
              padding: EdgeInsets.symmetric(vertical: 10),
              children: [
                Text(
                  widget.flashcardSet.category, // إضافة عنوان الفئة
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (int i = 0; i < widget.flashcardSet.cards.length; i++)
                      InkWell(
                        onTap: index != i
                            ? () {
                                pageController.animateToPage(
                                  i,
                                  curve: Curves.ease,
                                  duration: Duration(milliseconds: 500),
                                );
                              }
                            : null,
                        child: Container(
                          padding: EdgeInsets.all(8),
                          margin:
                              EdgeInsets.symmetric(vertical: 10, horizontal: 2),
                          decoration: BoxDecoration(
                            color: index == i
                                ? Colors
                                    .blue // إذا كان الكارت الحالي يساوي الكارت الموجود في اللوب معنى ذلك أنه محدد، لذلك يتم تلوينه بالأزرق، وإلا يتم تلوينه بالأبيض
                                : Colors.white,
                            border: Border.all(color: Colors.blue),
                            borderRadius: BorderRadius.circular(50),
                          ),
                          height: 20,
                          width: 20,
                        ),
                      )
                  ],
                ),
                InkWell(
                  onTap: () {
                    goNextPage(); // الانتقال إلى الكارت التالي
                  },
                  child: FlashCardWidget(
                    flashCardSet: widget.flashcardSet,
                    index: index, // تحديث الكارت الحالي
                    removeFlashCard: widget.removeFlashCard,
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}
