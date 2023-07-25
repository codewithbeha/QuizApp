//import material package
import 'package:flutter/material.dart';
import './screens/home_screen.dart';

void main() {
  // var db = DBconnect();
  // // db.addQuestion(Question(id: '20', title: 'What is 20 x 100 ?', options: {
  // //   '100': false, '2000': true, '500': false, '300': false,
  // // }));
  // db.fetchQuestions();   ->fetching the data static

  runApp(
    const MyApp(), //we will create this bellow
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      //remove debugbanner
      debugShowCheckedModeBanner: false,
      //set a home page
      home: HomeScreen(), //we will create this in separate file.
    );
  }
}
