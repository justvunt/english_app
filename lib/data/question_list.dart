import 'package:do_it/model/question_model.dart';

List<QuestionModel> questions = [
  QuestionModel('What is the capital of Vietnam?', 
  {
    "HCMC": false,
    "Da Nang": false,
    "Hanoi": true,
    "Hai Phong": false
  }),

  QuestionModel('teacher', 
  {
    "học sinh": false,
    "giáo viên": true,
    "sinh viên": false,
    "công nhân": false
  }),

  QuestionModel('goodbye', 
  {
    "xin chào": false,
    "tạm biệt": true,
    "hứng khởi": false,
    "bắt tay": false
  }),
];