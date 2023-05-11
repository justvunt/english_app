import 'package:do_it/pages/home_page.dart';
import 'package:do_it/pages/main_revise_page.dart';
import 'package:do_it/pages/quiz_page.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  final int initialPage ;
  // const MainPage({super.key});
  const MainPage({Key? key, required this.initialPage}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
  
}

class _MainPageState extends State<MainPage> {
  List pages = [
      const HomePage(),
      const QuizPage(),
      const MainRevisePage()
    ];

  int currentIndex = 0;
  void onTab(int index){
    setState(() {
      currentIndex = index;
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      currentIndex = widget.initialPage;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(title: Text("Do it"),
      backgroundColor: Color(0xFF21B6A8),),
      body: pages[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTab,
        currentIndex: currentIndex,
        items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.quiz),
          label: 'Quiz',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.person),
          label: 'Revise',
        ),
      ]),
    );
  }
}