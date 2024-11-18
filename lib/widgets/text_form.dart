import 'package:flutter/material.dart';

import '../constants/texts.dart';

class TextForm extends StatelessWidget {
  final value;
  final changeValue;
  final label_text;
  final error_text;
  final maxLines;
  final maxLength;
  final minLines;

  const TextForm({
    super.key,
    required this.value,
    required this.changeValue,
    required this.label_text,
    required this.error_text,
    this.maxLength = 100,
    this.maxLines = 1,
    this.minLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: maxLength,
      minLines: minLines,
      maxLines: maxLines,
      // ملء الحقل بالبيانات المخزنة مسبقًا إذا كانت الصفحة عبارة عن تحديث
      initialValue: value,
      style: Theme.of(context).textTheme.bodyMedium,
      decoration: InputDecoration(
        labelText: label_text,
        labelStyle: Theme.of(context).textTheme.labelLarge,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[400]!),
          borderRadius: BorderRadius.circular(15.0),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue[900]!),
          borderRadius: BorderRadius.circular(15.0),
        ),
        filled: true,
        fillColor: Colors.white,
        contentPadding: EdgeInsets.symmetric(
          horizontal: 20.0,
          vertical: 15.0,
        ),
      ),
      // التحقق من صحة الإدخالات التي يتم إدخالها في الحقل
      validator: (value) {
        if (value == null || value.isEmpty) {
          return error_text;
        }
        return null;
      },
      // حفظ البيانات المدخلة في المتغير المناسب
      onSaved: (value) {
        changeValue(value);
      },
    );
  }
}
