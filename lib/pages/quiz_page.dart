import 'package:do_it/data/question_list.dart';
import 'package:do_it/model/quiz_model.dart';
import 'package:do_it/network/network_request.dart';
import 'package:do_it/pages/result_page.dart';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Quiz> quizData = [];
  Color mainColor = Color(0xFF21B6A8);
  Color textColor = Colors.white;
  Color rightColor = Color(0xFF21B6A8);
  Color wrongColor = Colors.red;
  Color btnColor = Color.fromARGB(255, 255, 255, 255);
  int score = 0;

  PageController? _controller = PageController(initialPage: 0);
  bool isPressed = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetchQuiz().then((dataFromServer) {
      setState(() {
        quizData = dataFromServer.where((element) => element.quizType != "fill_in").toList();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(18.0),
      child: PageView.builder(
        physics: const NeverScrollableScrollPhysics(),
        controller: _controller!,
        onPageChanged: (page) {
          setState(() {
            isPressed = false;
          });
        },
        itemCount: quizData.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Text("Question ${index + 1}/${quizData.length}"),
              const SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 150,
                color: Color(0xFFFDDD5C),
                child: Center(
                  child: Text(
                    quizData[index].word!,
                    style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              for (int i = 0; i < quizData[index].choices!.length; i++)
                Container(
                  width: MediaQuery.of(context).size.width * 0.75,
                  margin: EdgeInsets.only(bottom: 21.0),
                  child: SizedBox(
                    height: 55,
                    child: ElevatedButton(
                      onPressed: isPressed
                          ? () => {}
                          : () {
                              if (quizData[index].choices![i] == quizData[index].ans) {
                                score += 1;
                              }
                              ;
                              setState(() {
                                isPressed = true;
                              });
                            },
                      style: ButtonStyle(
                        backgroundColor: isPressed
                      ? quizData[index].choices![i] == quizData[index].ans
                          ? MaterialStateProperty.all<Color>(rightColor)
                          : MaterialStateProperty.all<Color>(wrongColor)
                      : MaterialStateProperty.all<Color>(btnColor),
                        // backgroundColor: MaterialStateProperty.all<Color>(btnColor),
                        shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6.0),
                            side: BorderSide(width: 1, color: Color.fromARGB(255, 173, 169, 169)),
                          ),
                        ),
                      ),
                      child: Text(quizData[index].choices![i], style: TextStyle(color: Colors.black),),
                    ),
                  ),
                ),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  OutlinedButton(
                      onPressed: isPressed
                          ? index + 1 == quizData.length
                              ? () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ResultPage(score)));
                                }
                              : () {
                                  _controller!.nextPage(
                                      duration: Duration(milliseconds: 500),
                                      curve: Curves.linear);
                                }
                          : null,
                      child: Text(
                        index + 1 == quizData.length
                            ? "See result"
                            : "Next question",
                        style: TextStyle(color: Colors.black),
                      )),
                ],
              )
            ],
          );
        },
      ),
    ));
  }
}
