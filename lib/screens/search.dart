import 'package:flashcards/model.dart'; // استيراد الحزمة التي تحتوي على فئة مجموعة بطاقات التعليمية
import 'package:flutter/material.dart'; // استيراد الحزمة التي تحتوي على واجهات المستخدم
import '/widgets/body_sets.dart'; // استيراد الحزمة التي تحتوي على الجسم لعرض مجموعات بطاقات التعليمية

class SearchPage extends StatefulWidget {
  final removeFlashCardSet;
  final List<FlashcardSet>?
      flashcardSets; // القوائم الفرعية لمجموعات بطاقات التعليمية

  SearchPage({
    required this.flashcardSets,
    required this.removeFlashCardSet,
  });

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  String _searchQuery = ''; // سلسلة البحث
  TextEditingController searchController =
      TextEditingController(); // متحكم نص البحث
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var results = null; // النتائج الفرعية لمجموعات بطاقات التعليمية
    if (widget.flashcardSets != null) {
      // التحقق من توفر القوائم الفرعية لمجموعات بطاقات التعليمية
      setState(() {
        results = widget.flashcardSets!.where(
          // تحديث النتائج الفرعية لمجموعات بطاقات التعليمية
          (flashcardSet) {
            if (flashcardSet
                    .title // التحقق من تطابق عنوان مجموعة بطاقات التعليمية مع سلسلة البحث
                    .toString()
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase()) ||
                flashcardSet
                    .category // التحقق من تطابق فئة مجموعة بطاقات التعليمية مع سلسلة البحث
                    .toString()
                    .toLowerCase()
                    .contains(_searchQuery.toLowerCase())) {
              return true; // إرجاع القيمة الحقيقية إذا تطابقت النتيجة
            }
            return false; // إرجاع القيمة الكاذبة إذا لم تتطابق النتيجة
          },
        ).toList(); // تحويل النتائج الفرعية لمجموعات بطاقات التعليمية إلى قائمة
      });
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextField(
          controller: searchController, // إضافة متحكم نص البحث إلى حقل النص
          textDirection: TextDirection.rtl, // توجيه النص من اليمين إلى اليسار
          style: Theme.of(context).textTheme.headlineMedium, // إضافة نمط النص
          decoration: InputDecoration(
            hintText: 'بحث', // نص التلميح لحقل البحث
            hintTextDirection:
                TextDirection.rtl, // توجيه نص التلميح من اليمين إلى اليسار
            border: InputBorder.none, // عدم وجود حدود لحقل البحث
          ),
          onChanged: (value) {
            setState(() {
              _searchQuery = value; // تحديث سلسلة البحث عند تغيير نص البحث
            });
          },
        ),
        automaticallyImplyLeading: false, // إخفاء الزر الرئيسي لعودة الصفحة
        actions: [
          IconButton(
            icon: Icon(
              Icons.clear,
              color: Colors.black,
            ),
            onPressed: () {
              setState(() {
                _searchQuery = ''; // مسح سلسلة البحث
              });
              searchController.clear(); // مسح متحكم نص البحث
            },
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context); // عودة إلى الصفحة السابقة
            },
            icon: Icon(
              Icons.arrow_forward,
              color: Colors.black,
            ),
          )
        ],
      ),
      body: FlashCardSetsBody(
        removeFlashCardSet: widget.removeFlashCardSet,
        flashcardSets: results,
      ), // عرض مجموعات بطاقات التعليمية كبطاقات مخصصة مع عناوينها وفئاتها
    );
  }
}
