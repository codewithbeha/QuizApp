import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';

class QuestionWidget extends StatelessWidget {
  const QuestionWidget(
    { Key? key, required this.indexAction, required this.totalQuestions, required this.question}
    ): super(key: key);

  //here we need the question title , total number question and and also the index.
  final String question;
  final int indexAction;
  final int totalQuestions;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        'Question ${indexAction+1}/$totalQuestions: $question',
        style: const TextStyle(
          fontSize: 24.0,
          color: questionColor,
        ),
        ),
    
    );
  }
}