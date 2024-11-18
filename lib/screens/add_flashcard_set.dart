import 'package:flashcards/constants/numbers.dart';
import 'package:flashcards/constants/texts.dart';
import 'package:flashcards/model.dart';
import 'package:flutter/material.dart';
import '../widgets/text_form.dart';

class AddFlashcardSetPage extends StatefulWidget {
  // تمرير الوظائف لإضافة وتحديث مجموعة البطاقات والبيانات المخزنة سابقًا
  final addFlashCardSet;
  final updateFlashcardSet;
  // تحديد ما إذا كانت الصفحة عبارة عن تحديث أو إضافة جديدة
  bool update;
  final flashcardSet;

  AddFlashcardSetPage({
    required this.addFlashCardSet,
    required this.updateFlashcardSet,
    this.flashcardSet,
    this.update = false,
  });

  @override
  _AddFlashcardSetPageState createState() => _AddFlashcardSetPageState();
}

class _AddFlashcardSetPageState extends State<AddFlashcardSetPage> {
  // مفتاح النموذج الذي يتم استخدامه للتحقق من صحة الإدخالات وحفظ البيانات
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _category = '';

  @override
  void initState() {
    // ملء الحقول بالبيانات المخزنة مسبقًا إذا كانت الصفحة عبارة عن تحديث
    if (widget.update) {
      _category = widget.flashcardSet.category;
      _title = widget.flashcardSet.title;
    }
    super.initState();
  }

  changeCategory(value) {
    setState(() {
      _category = value;
    });
  }

  changeTitle(value) {
    setState(() {
      _title = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          // عرض عنوان الصفحة بناءً على ما إذا كانت الصفحة عبارة عن تحديث أو إضافة جديدة
          title: Text(
            widget.update ? updateFlashCardSetText : addFlashCardSetText,
          ),
          backgroundColor: Colors.blue[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              // استخدام المفتاح الذي تم إنشاؤه في الأعلى للتحقق من صحة الإدخالات وحفظ البيانات
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 30.0),
                  // إضافة حقل الإدخال الخاص بعنوان مجموعة البطاقات
                  TextForm(
                    error_text: error_length_title,
                    maxLength: maxLengthTitle,
                    minLines: minLinesTitle,
                    maxLines: maxLengthTitle,
                    value: _title,
                    changeValue: changeTitle,
                    label_text: title_label_text,
                  ),
                  SizedBox(height: 16.0),
                  // إضافة حقل الإدخال الخاص بفئة مجموعة البطاقات
                  TextForm(
                    maxLength: maxLengthCategory,
                    minLines: minLinesCategory,
                    maxLines: maxLengthCategory,
                    error_text: error_length_category,
                    value: _category,
                    changeValue: changeCategory,
                    label_text: category_label_text,
                  ),
                  SizedBox(height: 30.0),
                  // إضافة زر لإضافة أو تحديث مجموعة البطاقات
                  ElevatedButton(
                    onPressed: () {
                      // التحقق من صحة البيانات المدخلة بالنسبة للحقلين
                      if (_formKey.currentState!.validate()) {
                        // حفظ البيانات المدخلة في المتغيرات المناسبة
                        _formKey.currentState!.save();
                        // إنشاء مجموعة بطاقات جديدة وإضافتها إلى القائمة إذا كانت الصفحة عبارة عن إضافة جديدة
                        if (!widget.update) {
                          FlashcardSet set = FlashcardSet(
                            title: _title,
                            category: _category,
                            cards: [],
                          );
                          setState(() {
                            widget.addFlashCardSet(set);
                          });
                        }
                        // تحديث بيانات مجموعة البطاقات إذا كانت الصفحة عبارة عن تحديث
                        else {
                          widget.flashcardSet.title = _title;
                          widget.flashcardSet.category = _category;
                          widget.updateFlashcardSet(widget.flashcardSet);
                        }
                        // الانتقال إلى الصفحة السابقة بعد الانتهاء من الإضافة / التحديث
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      // تغيير نص الزر بناءً على ما إذا كانت الصفحة عبارة عن تحديث أو إضافة جديدة
                      widget.update
                          ? updateFlashCardSetText
                          : addFlashCardSetText,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    // تخصيص مظهر الزر
                    style: Theme.of(context).elevatedButtonTheme.style,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
