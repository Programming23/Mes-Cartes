import 'package:flutter/material.dart';
import '/constants/texts.dart';

class AboutUsText extends StatelessWidget {
  const AboutUsText({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      aboutUstext,
      style: Theme.of(context).textTheme.bodyLarge,
    );
  }
}
