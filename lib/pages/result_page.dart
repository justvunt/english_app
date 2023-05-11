import 'package:do_it/pages/main_page.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final int score;
  const ResultPage(this.score, {Key? key}) : super(key: key);

  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFCB42),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Congratulations",
              style: TextStyle(color: Colors.white, fontSize: 38, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10,),
            Text("Your score is :", 
              style: TextStyle(fontSize: 21, color: Colors.white),
            ),
            SizedBox(height: 30,),
            Text("${widget.score}",
            style: TextStyle(
              color: Color.fromARGB(255, 18, 78, 218),
              fontSize: 40,
              fontWeight: FontWeight.w600
            ),),
            SizedBox(height: 30,),
            MaterialButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>MainPage(initialPage: 0)));
              }, 
              color: Color(0xFF21B6A8),
              child: Text("Repeat the Quizz"),
            )
          ]
          ),
      )
    );
  }
}