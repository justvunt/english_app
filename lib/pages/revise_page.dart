import 'package:do_it/component/fill_letter.dart';
import 'package:do_it/component/multiple_choices.dart';
import 'package:do_it/component/notification.dart';
import 'package:do_it/model/vocab_model.dart';
import 'package:do_it/network/vocab_request.dart';
import 'package:do_it/pages/main_page.dart';
import 'package:do_it/pages/main_revise_page.dart';
import 'package:do_it/pages/new_component.dart';
import 'package:flutter/material.dart';

class RevisePage extends StatefulWidget {
  const RevisePage({super.key});

  @override
  State<RevisePage> createState() => _RevisePageState();
}

class _RevisePageState extends State<RevisePage> {
  String word = "GirlFriend";
  List<Vocab> vocabList = [];
  final TextEditingController _answerController = TextEditingController();
  var gapList = [];
  String textWord = "";
  int previousIndex = -2;
  bool isContinue = false;
  int wordSize = 0;
  bool isLoading = true;
  var slider = [];
  int crrPage = 0;

  bool isLast = false;
  PageController _controller = PageController(initialPage: 0);
  double _progessValue = 0.0;
  double _progressStep = 0.0;
  Set<Vocab> rememberList = Set<Vocab>();
  Set<Vocab> forgetList = Set<Vocab>();
  Map<Vocab, int> tracker = {};

  void handleNextPage(String status, {Vocab? vocab}) {
    if (vocab != null) {
      if (status == "W") {
        //
      } else if (status == "R") {
        tracker.update(vocab, (value) => value + 1);
      }
    }
    if (crrPage < slider.length - 1) {
      setState(() {
        _progessValue += _progressStep;
      });
      _controller.nextPage(
          duration: Duration(milliseconds: 200), curve: Curves.easeInExpo);
    } else {
      bool checkNotice1 = false;
      bool checkNotice2 = false;
      DateTime timeNow = DateTime.now();
      final VocabRequest vocabRequest = VocabRequest("");
      tracker.forEach((key, value) {
        if (value >= 2) {
          int level = key.level!;
          vocabRequest.updateLevel(key.id!, level + 1, remindTime: timeNow);
          if (checkNotice1 == false) {
            if (level == 1) {
              NotificationAPI().showNotification(
                  title: 'Do It',
                  body: 'Hey, It\'s time to revise !',
                  scheduleTime: timeNow.add(Duration(days: 1)));
            } else if (level == 2) {
              NotificationAPI().showNotification(
                  title: 'Do It',
                  body: 'Hey, It\'s time to revise !',
                  scheduleTime: timeNow.add(Duration(days: 6)));
            } else if (level == 3) {
              NotificationAPI().showNotification(
                  title: 'Do It',
                  body: 'Hey, It\'s time to revise !',
                  scheduleTime: timeNow.add(Duration(days: 21)));
            } else if (level == 4) {
              NotificationAPI().showNotification(
                  title: 'Do It',
                  body: 'Hey, It\'s time to revise !',
                  scheduleTime: timeNow.add(Duration(days: 30)));
            }
            setState(() {
              checkNotice1 = true;
            });
          }
        } else {
          vocabRequest.updateLevel(key.id!, 1, remindTime: timeNow);
          if (checkNotice2 == false) {
            NotificationAPI()
                .showNotification(title: 'Do It', body: 'Hey, It\'s time to revise !', scheduleTime: timeNow.add(Duration(minutes: 10)));
            setState(() {
              checkNotice2 = true;
            });
          }
        }
      });
      setState(() {
        isLast = true;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationAPI().initNotification(() {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MainRevisePage()));
    });
    setState(() {
      isLoading = true;
      textWord = '_' * word.length;
      wordSize = word.length;
      _answerController.text = textWord;
    });

    final vocabRequest = VocabRequest("");
    vocabRequest.fetchReviseVocab().then((value) {
      setState(() {
        vocabList = value.toList();
        isLoading = false;
      });
    }).then((value) {
      for (int i = 0; i < vocabList.length; i++) {
        tracker[vocabList[i]] = 0;
        slider.add(FillLetter(
          vocab: vocabList[i],
          setDisplay: handleNextPage,
        ));
        slider.add(MultipleChoices(
          vocab: vocabList[i],
          vocabList: vocabList,
          type: "EV",
          setDisplay: handleNextPage,
        ));
        slider.add(MultipleChoices(
          vocab: vocabList[i],
          vocabList: vocabList,
          type: "VE",
          setDisplay: handleNextPage,
        ));
      }
      slider.shuffle();
      setState(() {
        _progressStep = 1 / slider.length;
      });
    });
  }

  void handleTextChange(value) {
    value = value.toString().toUpperCase();
    String letter = value[value.length - 1];
    int index = textWord.indexOf('_');
    if (index != -1) {
      if (value.length < textWord.length) {
        String oldLetter = "";
        int removeIndex = value.indexOf('_') - 1;
        if (removeIndex >= 0)
          oldLetter = value[removeIndex];
        else {
          oldLetter = letter;
          removeIndex = value.length - 1;
        }

        setState(() {
          textWord = textWord.replaceFirst(oldLetter, '_', removeIndex);
          _answerController.text = textWord.toUpperCase();
          _answerController.selection =
              TextSelection.collapsed(offset: wordSize);
        });
      } else {
        setState(() {
          textWord = textWord.replaceFirst('_', letter, index);
          _answerController.text = textWord.toUpperCase();
          _answerController.selection =
              TextSelection.collapsed(offset: wordSize);
        });
        if (textWord.indexOf('_') == -1) {
          setState(() {
            isContinue = true;
          });
        }
      }
    } else {
      if (value.length < textWord.length) {
        for (int i = 0; i < textWord.length - value.length; i++) {
          textWord = value + '_';
        }
        setState(() {
          isContinue = false;
        });
      }
      setState(() {
        _answerController.text = textWord.toUpperCase();
        _answerController.selection = TextSelection.collapsed(offset: wordSize);
      });
    }
  }

  void handleContinue() {
    if (textWord.toLowerCase() == word.toLowerCase()) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            elevation: 0,
            backgroundColor: Colors.transparent,
            child: Stack(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(
                    top: 100,
                    bottom: 16,
                    left: 16,
                    right: 16,
                  ),
                  margin: EdgeInsets.only(top: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(17),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 10.0,
                        offset: Offset(0.0, 10.0),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text(
                        "Congratulations!",
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        "Correctly !",
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text("Continue"),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 16,
                  right: 16,
                  child: CircleAvatar(
                    backgroundColor: Colors.green,
                    radius: 30,
                    child: Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else
      print("Oops");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          // backgroundColor: Color(0xFF21B6A8),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          title: Text(
            "REVISE PAGE",
            style: TextStyle(color: Color(0xFF2B2B2B)),
          ),
          automaticallyImplyLeading: false,
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : isLast
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("You have done !"),
                        SizedBox(
                          height: 30,
                        ),
                        SizedBox(
                          width: 200,
                          height: 50,
                          child: ElevatedButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        MainPage(initialPage: 2),
                                  ),
                                );
                              },
                              style: ButtonStyle(
                                  shape: MaterialStateProperty.all(
                                      RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(32),
                              ))),
                              child: Text("Finish")),
                        ),
                      ],
                    ),
                  )
                : PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: _controller,
                    itemCount: slider.length,
                    onPageChanged: (value) {
                      setState(() {
                        crrPage = value;
                      });
                    },
                    itemBuilder: (context, index) {
                      return WillPopScope(
                        onWillPop: () async => false,
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: Color.fromARGB(255, 255, 255, 255),
                                      width: 1.0)),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 0.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.0),
                                  child: LinearProgressIndicator(
                                    value: _progessValue,
                                    backgroundColor: Colors.grey[300],
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Color.fromARGB(255, 35, 189, 27)),
                                    minHeight: 10.0,
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            slider[index],
                            SizedBox(
                              height: 30,
                            ),
                            TextButton(
                                onPressed: () {
                                  // final GlobalKey<slider[index]>
                                  // print(slider[index].vocab.id);
                                  handleNextPage.call("W",
                                      vocab: slider[index].vocab);
                                },
                                child: Text(
                                  "I don't remember !",
                                  style: TextStyle(fontSize: 18),
                                ))
                          ],
                        ),
                      );
                    }));
  }
}
