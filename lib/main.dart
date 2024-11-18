import 'dart:async';
import '/screens/about_us.dart'; // يستورد واجهة المستخدم لصفحة "من نحن"
import '/screens/add_flashcard_set.dart'; // يستورد واجهة المستخدم لإضافة مجموعة جديدة من البطاقات
import '/screens/loading_page.dart'; // يستورد واجهة المستخدم لصفحة التحميل
import '/screens/search.dart'; // يستورد واجهة المستخدم لصفحة البحث
import 'package:sqflite/sqflite.dart'; // يستورد مكتبة sqflite
import 'db_helper.dart'; // يستورد المساعد لقاعدة البيانات
import 'screens/add_flashcard.dart'; // يستورد واجهة المستخدم لإضافة بطاقة جديدة
import 'screens/flashcard_page.dart'; // يستورد واجهة المستخدم لصفحة البطاقات
import 'package:flutter/material.dart'; // يستورد مكتبة flutter لصناعة تطبيقات الهواتف الذكية
import 'model.dart'; // يستورد نموذج البطاقات
import 'package:sqflite_common_ffi/sqflite_ffi.dart'
    as sqflite; // يستورد مكتبة sqflite_ffi
import 'screens/home.dart'; // يستورد واجهة المستخدم للصفحة الرئيسية
import 'constants/theme.dart'; // يستورد الثيم الخاص بالتطبيق

void main() {
  // الدالة الرئيسية للتطبيق
  //databaseFactory = sqflite.databaseFactoryFfi; // يستخدم sqflite.databaseFactoryFfi لتحميل قاعدة بيانات يتم استخدامها في التطبيق
  runApp(MyApp()); // يشغل التطبيق
}

class MyApp extends StatefulWidget {
  // يعرف الصفحة الرئيسية للتطبيق
  const MyApp({
    super.key,
  });

  @override
  State<MyApp> createState() => _MyAppState(); // يرجع حالة التطبيق
}

class _MyAppState extends State<MyApp> {
  // يعرف حالة التطبيق
  late DbHelper dbHelper; // يعرف dbHelper كـ late
  List<FlashcardSet>? data; // يعرف data كـ List<FlashcardSet>
  int currentIndex = 0; // يعرف currentIndex كـ 0

  @override
  void initState() {
    // تهيئة المتغيرات الأولية للتطبيق
    dbHelper = DbHelper(); // يربط dbHelper بـ DbHelper
    loadData(); // يحمل data
    super.initState();
  }

  loadData() async {
    // دالة لتحميل البيانات من قاعدة البيانات
    dbHelper.getAllFlashcardSets().then((value) {
      // يستخدم dbHelper.getAllFlashcardSets() للحصول على جميع مجموعات البطاقات
      setState(() {
        // يستخدم setState لتحديث الحالة الداخلية للتطبيق
        data =
            value; // يعيد القيمة المسترجعة من dbHelper.getAllFlashcardSets() إلى data
      });
    });
  }

  addFlashcard(Flashcard flashCard, FlashcardSet flashcardSet) async {
    // دالة لإضافة بطاقة جديدة
    setState(() {
      dbHelper.saveFlashcard(
          flashCard); // يستخدم dbHelper.saveFlashcard() لحفظ flashCard
      // يستخدم setState لتحديث الحالة الداخلية للتطبيق
      flashcardSet.cards
          .add(flashCard); // يضيف flashCard إلى flashcardSet.cards
    });
  }

  addFlashcardSet(FlashcardSet flashcardSet) {
    // دالة لإضافة مجموعة بطاقات جديدة
    dbHelper.saveFlashcardSet(flashcardSet).then(
      (int id) {
        // يستخدم dbHelper.saveFlashcardSet() لحفظ flashcardSet
        // يستخدم setState لتحديث الحالة الداخلية للتطبيق
        setState(() {
          flashcardSet.id = id;
          data!.add(flashcardSet); // يضيف flashcardSet إلى data
        });
      },
    );
  }

  updateFlashcard(Flashcard flashCard) async {
    // دالة لتحديث بطاقة معينة
    setState(() {
      // يستخدم setState لتحديث الحالة الداخلية للتطبيق
      dbHelper.updateFlashcard(
          flashCard); // يستخدم dbHelper.updateFlashcard() لتحديث flashCard
    });
  }

  updateFlashcardSet(FlashcardSet flashCardSet) async {
    // دالة لتحديث مجموعة بطاقات معينة
    setState(() {
      // يستخدم setState لتحديث الحالة الداخلية للتطبيق
      dbHelper.updateFlashcardSet(
          flashCardSet); // يستخدم dbHelper.updateFlashcardSet() لتحديث flashCardSet
    });
  }

  removeFlashCard(Flashcard flashCard) async {
    // دالة لحذف بطاقة
    setState(() {
      // يستخدم setState لتحديث الحالة الداخلية للتطبيق
      dbHelper.deleteFlashcard(
          flashCard); // يستخدم dbHelper.deleteFlashcard() لحذف flashCard
    });
  }

  removeFlashCardSet(FlashcardSet flashcardSet) async {
    // دالة لحذف مجموعة بطاقات
    setState(() {
      // يستخدم setState لتحديث الحالة الداخلية للتطبيق
      data!
          .remove(flashcardSet); // يستخدم List.removeAt() لحذف المجموعة الحالية
      dbHelper.deleteFlashcardSet(
        flashcardSet.id,
      ); // يستخدم dbHelper.deleteFlashcardSet() لحذف مجموعة البطاقات
    });
  }

  changeIndex(index) {
    // دالة لتغيير الفهرس الحالي
    setState(() {
      // يستخدم setState لتحديث الحالة الداخلية للتطبيق
      currentIndex = index; // يعيد الفهرس الحالي
    });
  }

  @override
  Widget build(BuildContext context) {
    // دالة لبناء التطبيق
    return MaterialApp(
      // تعطيل شعار التصحيح
      debugShowCheckedModeBanner: false,
      // الشاشة الأولى التي تظهر للمستخدم هي شاشة التحميل
      initialRoute: '/loading',
      // إعدادات السمة الظاهرية للتطبيق
      theme: theme,
      // تحديد الصفحة التي تظهر عندما يتم استدعاء الرابط المطابق
      onGenerateRoute: (route) {
        // عندما يتم استدعاء الرابط '/home'، يتم إرجاع صفحة HomePage
        if (route.name == '/home') {
          return MaterialPageRoute(
            builder: (context) => HomePage(
              flashcardSets: (data != null) ? data : null,
              removeFlashCardSet: removeFlashCardSet,
              changeIndex: changeIndex,
              currentIndex: currentIndex,
            ),
          );
        }
        // عندما يتم استدعاء الرابط '/loading'، يتم إرجاع صفحة LoadingPage
        else if (route.name == '/loading') {
          return MaterialPageRoute(
            builder: (context) => LoadingPage(),
          );
        }
        // عندما يتم استدعاء الرابط '/search'، يتم إرجاع صفحة SearchPage
        else if (route.name == '/search') {
          return MaterialPageRoute(
            builder: (context) => SearchPage(
              removeFlashCardSet: removeFlashCardSet,
              flashcardSets: (data != null) ? data : null,
            ),
          );
        }
        // عندما يتم استدعاء الرابط '/about_us'، يتم إرجاع صفحة AboutUs
        else if (route.name == '/about_us') {
          return MaterialPageRoute(
            builder: (context) => AboutUs(
              changeIndex: changeIndex,
              currentIndex: currentIndex,
            ),
          );
        }
        // عندما يتم استدعاء الرابط '/flashcard_set'، يتم إرجاع صفحة FlashcardSetScreen
        else if (route.name == '/flashcard_set') {
          List args = route.arguments as List;
          return MaterialPageRoute(
            builder: (context) => FlashcardSetScreen(
              removeFlashCard: removeFlashCard,
              removeFlashCardSet: removeFlashCardSet,
              flashcardSet: args[0] as FlashcardSet,
              index: args[1],
            ),
          );
        }
        // عندما يتم استدعاء الرابط '/add_flashcard'، يتم إرجاع صفحة AddFlashcardPage
        else if (route.name == '/add_flashcard') {
          List args = route.arguments as List;
          return MaterialPageRoute(
            builder: (context) => AddFlashcardPage(
              update: args[0] == 'update' ? true : false,
              flashcardSet: args[1],
              flashcard: args[1],
              addFlashCard: addFlashcard,
              updateFlashcard: updateFlashcard,
            ),
          );
        }
        // عندما يتم استدعاء الرابط '/add_flashcardSet'، يتم إرجاع صفحة AddFlashcardSetPage
        else if (route.name == '/add_flashcardSet') {
          List args = route.arguments as List;
          return MaterialPageRoute(
            builder: (context) => AddFlashcardSetPage(
              addFlashCardSet: addFlashcardSet,
              updateFlashcardSet: updateFlashcardSet,
              update: args[0] == 'update' ? true : false,
              flashcardSet: args[0] == 'update' ? args[1] : null,
            ),
          );
        }
      },
    );
  }
}
