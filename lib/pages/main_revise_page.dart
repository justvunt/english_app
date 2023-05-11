import 'dart:convert';

import 'package:do_it/component/countdown_timer.dart';
import 'package:do_it/pages/revise_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MainRevisePage extends StatefulWidget {
  const MainRevisePage({super.key});

  @override
  State<MainRevisePage> createState() => _MainRevisePageState();
}

class _MainRevisePageState extends State<MainRevisePage> {
  String data = "";
  DateTime remindTime = DateTime.now();
  Duration diff = Duration(days: 1);
  bool isOK = false;
  bool isBtnActive = false;

  Future<String> fetchData() async {
    final response = await http
        .get(Uri.parse('https://api.justvu.com/api/Vocab/get-remind-time'));
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Fail to load data from API');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData().then((value) {
      setState(() {
        data = value;
      });
    }).then((value) {
      DateTime rightNow = DateTime.now();
      setState(() {
        remindTime = DateTime.parse(data);
        diff = remindTime.difference(rightNow);
        isOK = true;
      });
    });
  }

  void activeButton(){
    setState(() {
      isBtnActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return isOK ? Scaffold(
        body: Center(
      child: SizedBox(
        height: 500,
        width: 500,
        child: Column(
          children: [
            CountdownTimer(duration: diff, activeButton: activeButton,),
            SizedBox(height: 50,),
            SizedBox(
              width: 220,
              height: 60,
              child: ElevatedButton(
                  onPressed: isBtnActive ? () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => RevisePage()));
                  } : null,
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Color(0xFF21B6A8)),
                      shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  ))),
                  child: Text("Revise",style: TextStyle(fontSize: 18),)),
            ),
          ],
        ),
      ),
    )) 
    :
    Center(
      child: CircularProgressIndicator(),
    );
  }
}
