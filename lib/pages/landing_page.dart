import 'package:do_it/model/quiz_model.dart';
import 'package:do_it/network/network_request.dart';
import 'package:do_it/pages/main_page.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatelessWidget {
  const LandingPage({super.key});

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFCB42),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset('assets/images/logo.png', width: 200, height: 300,),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color(0xff006E7F),
              onPrimary: Colors.white,
              shadowColor: Colors.greenAccent,
              elevation: 3,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(32.0)),
              minimumSize: Size(250, 65), 
            ),
            onPressed: () {
              Navigator.push(context,
              MaterialPageRoute(builder: (context) => MainPage(initialPage: 0))
              );
            },
            child: Text('Get goo !', style: TextStyle(fontSize: 21),),
          )
        ],)
      ),
    );
  }
}


class ListViewPage extends StatefulWidget {
  const ListViewPage({super.key});

  @override
  State<ListViewPage> createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {

  List<Quiz> quizData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NetworkRequest.fetchQuiz().then((dataFromServer){
      setState(() {
        quizData = dataFromServer;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: Text("Demoo")),
    );
  }
}