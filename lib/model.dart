class FlashcardSet {
  var id;
  String title;
  String category;
  List cards;

  FlashcardSet({
    this.id,
    required this.cards,
    required this.title,
    required this.category,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'category': category,
      'title': title,
    };
  }
}

class Flashcard {
  var id;
  var setId;
  String front;
  String back;

  Flashcard({
    required this.front,
    required this.back,
    this.id,
    this.setId,
  });

  Map<String, dynamic> toMap() {
    return {
      'front': front,
      'back': back,
      'id': id,
      'set_id': setId,
    };
  }
}
