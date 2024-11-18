import 'package:flashcards/constants/numbers.dart';
import 'package:flashcards/constants/texts.dart';
import 'package:flashcards/model.dart';
import 'package:flashcards/widgets/text_form.dart';
import 'package:flutter/material.dart';

class AddFlashcardPage extends StatefulWidget {
  final addFlashCard;
  final bool update;
  final flashcardSet;
  final flashcard;
  final updateFlashcard;

  AddFlashcardPage({
    required this.addFlashCard,
    required this.updateFlashcard,
    this.flashcardSet,
    this.flashcard,
    this.update = false,
  });

  @override
  _AddFlashcardPageState createState() => _AddFlashcardPageState();
}

class _AddFlashcardPageState extends State<AddFlashcardPage> {
  final _formKey = GlobalKey<FormState>();
  String _front = '';
  String _back = '';

  @override
  void initState() {
    if (widget.update) {
      _front = widget.flashcard!.front;
      _back = widget.flashcard!.back;
    }
    super.initState();
  }

  changeFront(value) {
    setState(() {
      _front = value;
    });
  }

  changeBack(value) {
    setState(() {
      _back = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.update ? updateFlashCardText : addFlashCardText),
          backgroundColor: Colors.blue[900],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  SizedBox(height: 30.0),
                  TextForm(
                    maxLength: maxLengthFront,
                    minLines: minLinesFront,
                    maxLines: maxLengthFront,
                    value: _front,
                    changeValue: changeFront,
                    label_text: front_label_text,
                    error_text: error_length_front,
                  ),
                  SizedBox(height: 16.0),
                  TextForm(
                    maxLength: maxLengthBack,
                    minLines: minLinesBack,
                    maxLines: maxLinesBack,
                    value: _back,
                    changeValue: changeBack,
                    label_text: back_label_text,
                    error_text: error_length_back,
                  ),
                  SizedBox(height: 30.0),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _formKey.currentState!.save();
                        if (!widget.update) {
                          Flashcard card = Flashcard(
                            front: _front,
                            back: _back,
                            setId: widget.flashcardSet!.id,
                          );
                          setState(() {
                            widget.addFlashCard(card, widget.flashcardSet);
                          });
                        } else {
                          widget.flashcard.front = _front;
                          widget.flashcard.back = _back;
                          setState(() {
                            widget.updateFlashcard(widget.flashcard);
                          });
                        }

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      widget.update ? updateFlashCardText : addFlashCardText,
                      style: TextStyle(
                        fontSize: 17.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
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
