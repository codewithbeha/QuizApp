import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: neutral,
          borderRadius: BorderRadius.circular(10.0),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16.0),
        child: const Text(
          'Next Question',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 18.0),
        ),
      ),
    );
  }
}
