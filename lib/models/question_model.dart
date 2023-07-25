//i will create question model here
//with a simple class

class Question {
  //define how every question will look like
  //every question have and id.

  final String id;
  //every qeustion will have a title
  final String title;
  //every title will have question
  final Map<String, bool> options;
  //options will look like {'1'- true , '2' - false}
  //create a constructor

  Question({
    required this.id,
    required this.title,
    required this.options,
  });

  //override the toString method to print the question to console
  @override
  String toString() {
    return 'Question(id: $id, title: $title, options: $options)';
  }
}
