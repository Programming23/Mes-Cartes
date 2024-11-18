import 'package:sqflite/sqflite.dart'; // استيراد حزمة sqflite
import 'package:path/path.dart'; // استيراد حزمة path
import 'model.dart'; // استيراد ملف flashcard_set.dart

// تعريف الفئة DbHelper
class DbHelper {
  static final _dbName = 'flashcards.db'; // تعريف اسم قاعدة البيانات
  static final _dbVersion = 1; // تعريف إصدار قاعدة البيانات
  static final _flashcardSetTable = 'flashcard_sets'; // تعريف اسم جدول الأوراق
  static final _flashcardTable = 'flashcards'; // تعريف اسم جدول البطاقات

  static Database? _database; // تعريف متغير القاعدة البياناتية

  // دالة الحصول على القاعدة البياناتية
  Future<Database> get database async {
    try {
      if (_database != null) {
        return _database!;
      }
      _database = await _initDatabase();
    } catch (e) {
      print(e);
    }

    return _database!;
  }

  // دالة إنشاء قاعدة البيانات
  Future<Database> _initDatabase() async {
    String dbPath = '/'; // تعريف مسار قاعدة البيانات

    // الحصول على مسار قاعدة البيانات
    await getDatabasesPath().then((value) => dbPath = value);
    final path = join(dbPath, _dbName);

    // فتح قاعدة البيانات
    return await openDatabase(path, version: _dbVersion, onCreate: _createDb);
  }

  // دالة إنشاء الجداول
  Future<void> _createDb(Database db, int version) async {
    // إنشاء جدول الأوراق
    await db.execute('''
    CREATE TABLE $_flashcardSetTable(
      id INTEGER PRIMARY KEY,
      title TEXT,
      category TEXT
    )
  ''');

    // إنشاء جدول البطاقات
    await db.execute('''
    CREATE TABLE $_flashcardTable(
      id INTEGER PRIMARY KEY,
      front TEXT,
      back TEXT,
      set_id INTEGER,
      FOREIGN KEY (set_id) REFERENCES $_flashcardSetTable (id) ON DELETE CASCADE
    )
  ''');
  }

  // هذه الدالة تأخذ مجموعة بطاقات تعليمية وتقوم بحفظها في قاعدة البيانات
  Future<int> saveFlashcardSet(FlashcardSet set) async {
    final db = await database;

    // يتم تشغيل العمليات داخل transaction() لضمان عملية الحفظ بشكل صحيح
    await db.transaction((txn) async {
      // يتم حفظ معلومات مجموعة البطاقات في الجدول المحدد باسم _flashcardSetTable وتمريرها ك map بواسطة دالة toMap()
      final setId = await txn.insert(_flashcardSetTable, set.toMap());

      // يتم تعيين معرف المجموعة المحفوظة للمجموعة التي تم تمريرها كباراميتر
      set.id = setId;

      // يتم حفظ بيانات البطاقات التعليمية الموجودة في المجموعة
      for (Flashcard card in set.cards) {
        // يتم تعيين معرف المجموعة الخاصة بالبطاقة
        card.setId = setId;

        // يتم حفظ بيانات البطاقة التعليمية في الجدول المحدد باسم _flashcardTable وتمريرها ك map بواسطة دالة toMap()
        final id = await txn.insert(_flashcardTable, card.toMap());

        // يتم تعيين معرف البطاقة المحفوظة للبطاقة التي تم حفظها
        card.id = id;
      }
    });
    return set.id;
  }

  // مسح كل البيانات في جداول قاعدة البيانات
  Future<void> deleteAll() async {
    final db = await database;

    await db.transaction((txn) async {
      // مسح جدول الأطقم
      await txn.delete(_flashcardSetTable);
      // مسح جدول البطاقات
      await txn.delete(_flashcardTable);
    });
  }

  // حفظ بطاقة جديدة في جدول البطاقات
  Future<void> saveFlashcard(Flashcard set) async {
    final db = await database;

    await db.transaction((txn) async {
      // إدراج البطاقة في جدول البطاقات
      final id = await txn.insert(_flashcardTable, set.toMap());
      // تعديل معرف البطاقة بعد إدراجها في الجدول
      set.id = id;
    });
  }

  Future<void> updateFlashcardSet(FlashcardSet set) async {
    final db = await database;

    await db.transaction((txn) async {
      // تحديث بيانات مجموعة البطاقات
      await txn.update(
        _flashcardSetTable,
        set.toMap(),
        where: 'id = ?',
        whereArgs: [set.id],
      );

      // حذف جميع بطاقات مجموعة البطاقات الحالية من جدول البطاقات
      await txn.delete(
        _flashcardTable,
        where: 'set_id = ?',
        whereArgs: [set.id],
      );

      // حفظ بيانات البطاقات التعليمية الموجودة في المجموعة بعد التحديث
      for (Flashcard card in set.cards) {
        card.setId = set.id;

        await txn.insert(_flashcardTable, card.toMap());
      }
    });
  }

  // تعديل بطاقة تعليمية موجودة بالفعل في قاعدة البيانات
  Future<void> updateFlashcard(Flashcard card) async {
    final db = await database;

    // يتم تحديث بيانات البطاقة التعليمية في الجدول المحدد باسم _flashcardTable وتمريرها ك map بواسطة دالة toMap()
    await db.update(_flashcardTable, card.toMap(),
        where: 'id = ?', whereArgs: [card.id]);
  }

  // هذه الدالة تقوم بحذف بطاقة تعليمية معينة من قاعدة البيانات
  Future<void> deleteFlashcard(Flashcard card) async {
    final db = await database;

    // يتم تحديد البطاقة المطلوب حذفها باستخدام معرف البطاقة ومعرف مجموعة البطاقة
    await db.delete(
      _flashcardTable,
      where: 'id = ? AND set_id = ?',
      whereArgs: [card.id, card.setId],
    );
  }

  // هذه الدالة تأخذ معرف مجموعة البطاقات التعليمية وتحذف المجموعة بالإضافة إلى جميع البطاقات الموجودة فيها
  Future<void> deleteFlashcardSet(int setId) async {
    final db = await database;

    await db.transaction((txn) async {
      // يتم حذف جميع البطاقات التعليمية التي تنتمي للمجموعة المحددة
      await txn.delete(
        _flashcardTable,
        where: 'set_id = ?',
        whereArgs: [setId],
      );

      // يتم حذف مجموعة البطاقات التعليمية المحددة
      await txn.delete(
        _flashcardSetTable,
        where: 'id = ?',
        whereArgs: [setId],
      );
    });
  }

  Future<List<FlashcardSet>> getAllFlashcardSets() async {
    final db = await database;
    final sets = <FlashcardSet>[];

    // إرجاع كل المجموعات الموجودة في قاعدة البيانات
    final setRows = await db.query(_flashcardSetTable);

    for (final setRow in setRows) {
      // جلب بيانات البطاقات التعليمية الخاصة بالمجموعة المحددة
      final cardRows = await db.query(
        _flashcardTable,
        where: 'set_id = ?',
        whereArgs: [setRow['id']],
      );
      List cards = [];
      // إضافة البطاقات التعليمية إلى المجموعة
      for (final cardRow in cardRows) {
        final card = Flashcard(
          id: cardRow['id'],
          front: cardRow['front'] as String,
          back: cardRow['back'] as String,
        );
        cards.add(card);
      }

      // إنشاء كائن FlashcardSet وإضافة بيانات المجموعة إليه
      final set = FlashcardSet(
        id: setRow['id'],
        title: setRow['title'] as String,
        category: setRow['category'] as String,
        cards: cards,
      );

      sets.add(set);
    }

    return sets;
  }
}
