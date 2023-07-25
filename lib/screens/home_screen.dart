import 'package:flutter/material.dart';
import 'package:quiz_app/constants.dart';
import '../models/question_model.dart';
import '../widgets/question_widget.dart';
import '../widgets/next_button.dart';
import '../widgets/option_card.dart';
import '../widgets/result_box.dart';
import '../models/db_connect.dart';

//create the home screen widget
//im taking the statefulwidget because is going to be our parent widget and all the functions and variables will be in this widget, so we need
//to change our state widget state.

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //create an object for Dbconnect
  var db = DBconnect();
  // List<Question> _questions = [
  //   Question(
  //     id: '10',
  //     title: 'How much are 2+2=?',
  //     options: {'5': false, '30': false, '4': true, '199': false},
  //   ),
  //   Question(
  //     id: '11',
  //     title: 'How much are 3+2=?',
  //     options: {'5': true, '30': false, '4': false, '199': false},
  //   )
  // ];

  late Future _questions;

  Future<List<Question>> getData() async {
    return db.fetchQuestions();
  }

  @override
  void initState() {
    _questions = getData();
    super.initState();
  }

  //create an index to loop thought _questions
  int index = 0;
  //create a score variable
  int score = 0;
  //createa a boolean value to check if the user has clicked
  bool isPressed = false;
  //create a boolean value to show already selected
  bool isAlreadySelected = false;
  //create a function to display the next question
  void nextQuestion(int questionLength) {
    if (index == questionLength - 1) {
      //this is the block where the questions end.
      showDialog(
          context: context,
          barrierDismissible:
              false, //this will siable the dissmis function on the clicking outside of box.
          builder: (ctx) => ResultBox(
                result: score, //total points the user got
                questionLength: questionLength,
                onPressed: startOver, //out of how many questions
              ));
    } else {
      if (isPressed) {
        setState(() {
          index++;
          isPressed = false;
          isAlreadySelected = false;
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please select any option to continue...'),
          behavior: SnackBarBehavior.floating,
          margin: EdgeInsets.symmetric(vertical: 20.0),
        ));
      }
    }
  }

  //createa function to change color
  void checkAnswerAndUpdate(bool value) {
    if (isAlreadySelected) {
      return;
    } else {
      if (value == true) {
        score++;
      }
      setState(() {
        isPressed = true;
        isAlreadySelected = true;
      });
    }
  }

  //create a function to start over
  void startOver() {
    setState(() {
      index = 0;
      score = 0;
      isPressed = false;
      isAlreadySelected = false;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    //use the FutureBuilder Widget
    return FutureBuilder(
      future: _questions as Future<List<Question>>,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: background,
              appBar: AppBar(
                title: const Text('Quiz App'),
                titleTextStyle: const TextStyle(fontSize: 30.0, fontWeight: FontWeight.bold),
                backgroundColor: backgroundTitle,
                shadowColor: Colors.transparent,
                actions: [
                  Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Text(
                      'Score: $score',
                      style: const TextStyle(fontSize: 18.0),
                    ),
                  ),
                ],
              ),
              body: SizedBox(
                width: double.infinity,
                child: Column(children: [
                  const Divider(height: 25 , color: neutral),
                  QuestionWidget(
                    indexAction: index,
                    question: extractedData[index].title,
                    totalQuestions: extractedData.length,
                  ),
                  const Divider(color: neutral),
                  const SizedBox(height: 25.0),
                  for (int i = 0; i < extractedData[index].options.length; i++)
                    GestureDetector(
                      onTap: () => checkAnswerAndUpdate(
                        extractedData[index].options.values.toList()[i],
                      ),
                      child: OptionCard(
                        option: extractedData[index].options.keys.toList()[i],
                        color: isPressed
                            ? extractedData[index].options.values.toList()[i] ==
                                    true
                                ? correct
                                : incorrect
                            : neutral,
                      ),
                    ),
                ]),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0),
                  child: NextButton(
                     //the above function
                  ),
                ),
              ),
              floatingActionButtonLocation:
                  FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const CircularProgressIndicator(),
                const SizedBox(height: 20.0),
                Text('Please wait while Questions area loading...',
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                  decoration: TextDecoration.none,
                  fontSize: 14.0,
                ),
                
                )
              ],
            ),
          );
        }

        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
//import this file to our main app dart
