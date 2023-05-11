import 'package:do_it/component/back_flashcard.dart';
import 'package:do_it/component/fill_letter.dart';
import 'package:do_it/component/front_flashcard.dart';
import 'package:do_it/component/notification.dart';
import 'package:do_it/model/vocab_model.dart';
import 'package:do_it/network/vocab_request.dart';
import 'package:do_it/pages/main_revise_page.dart';
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

class VocabSetPage extends StatefulWidget {
  final String vocabSetID;
  final String vocabSetName;
  const VocabSetPage({
    Key? key,
    required this.vocabSetID,
    required this.vocabSetName,
  }) : super(key: key);

  @override
  State<VocabSetPage> createState() => _VocabSetPageState();
}

class _VocabSetPageState extends State<VocabSetPage> {
  final PageController _controller = PageController();
  final url =
      "https://www.oxfordlearnersdictionaries.com/media/english/us_pron/h/hel/hello/hello__us_1_rr.mp3";

  List<Vocab> vocabData = [];
  bool isFront = true;
  bool isLoading = false;
  bool isRevise = false;
  String word = "";
  final TextEditingController _answerController = TextEditingController();
  var gapList = [];
  String textWord = "";
  int previousIndex = -2;
  bool isContinue = false;
  int wordSize = 0;
  bool isLastQuiz = false;
  String freeTextValue = "";
  final AudioPlayer _audioPlayer = AudioPlayer();
  int crrPage = 0;
  bool isLast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    NotificationAPI().initNotification((){
      Navigator.push(context,
        MaterialPageRoute(builder: (context) => MainRevisePage())
      );
    });
    setState(() {
      isLoading = true;
    });
    final vocabRequest = VocabRequest(widget.vocabSetID);
    vocabRequest.fetchVocab().then((dataFromServer) {
      setState(() {
        vocabData = dataFromServer.toList();
      });
    }).then((value) {
      setState(() {
        isLoading = false;
      });
      _audioPlayer.play(vocabData[0].sound.toString());
    });
  }

  void UpdateReviseStatus(String status) {
    if (crrPage < vocabData.length - 1) {
      _controller.nextPage(
          duration: Duration(milliseconds: 100), curve: Curves.easeInOut);
      setState(() {
        isRevise = false;
      });
    } else {
      // Navigator.pop(context)
      final vocabRequest = VocabRequest("");
      DateTime remindTime = DateTime.now();
      for (int i = 0; i < vocabData.length; i++) {
        vocabRequest.updateLevel(vocabData[i].id!, 1, remindTime: remindTime);
      }
      NotificationAPI()
                .showNotification(title: 'Do It', body: 'Hey, It\'s time to revise !', scheduleTime: remindTime.add(Duration(minutes: 10)));
      setState(() {
        isLast = true;
      });
    }
  }

  void handleNextPage(newWord, soundUrl) {
    setState(() {
      word = newWord.toString().toUpperCase();
      textWord = '_' * word.length;
      wordSize = word.length;
      _answerController.text = textWord;
      isRevise = true;
      isFront = true;
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

  void handleContinue(String typedValue, String ans, String vn,
      {String soundUrl = ""}) {
    if (typedValue.toLowerCase().trim() == ans.toLowerCase().trim()) {
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
                        ans,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        vn,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (isLastQuiz) {
                              _controller.nextPage(
                                  duration: Duration(milliseconds: 100),
                                  curve: Curves.easeInOut);
                              setState(() {
                                isRevise = false;
                                isLastQuiz = false;
                              });
                            } else {
                              setState(() {
                                _answerController.text = "";
                                isLastQuiz = true;
                              });
                              if (soundUrl != "") {
                                _audioPlayer.play(soundUrl);
                              }
                            }
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
                        ans,
                        style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      Text(
                        vn,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 16.0),
                      ),
                      SizedBox(height: 24.0),
                      Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            if (isLastQuiz) {
                              setState(() {
                                _controller.nextPage(
                                    duration: Duration(milliseconds: 300),
                                    curve: Curves.easeInOut);
                                isRevise = false;
                                isLastQuiz = false;
                              });
                            } else {
                              setState(() {
                                _answerController.text = "";
                                isLastQuiz = true;
                              });
                              if (soundUrl != "") {
                                _audioPlayer.play(soundUrl);
                              }
                            }
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
                    backgroundColor: Colors.red,
                    radius: 30,
                    child: Icon(
                      Icons.error_outline_outlined,
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        centerTitle: false,
        title: Text(
          widget.vocabSetName,
          style: TextStyle(color: Colors.black, fontWeight:FontWeight.w800),
        ),
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context, true);
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
      ),
      floatingActionButton: null,
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
                            onPressed: (){
                              Navigator.pop(context);
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
              : Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35.0),
                    topRight: Radius.circular(35.0)
                  ),
                  color: Color.fromARGB(48, 212, 222, 222),
                ),
                child: Padding(
                    padding:
                        EdgeInsets.symmetric(vertical: 16.0, horizontal: 8.0),
                    child: PageView.builder(
                        controller: _controller,
                        itemCount: vocabData.length,
                        onPageChanged: (index) {
                          setState(() {
                            crrPage = index;
                          });
                          _audioPlayer.play(vocabData[index].sound.toString());
                        },
                        itemBuilder: (context, index) {
                          return isRevise
                              ? FillLetter(
                                  setDisplay: UpdateReviseStatus,
                                  vocab: vocabData[index])
                              : Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          setState(() {
                                            isFront = !isFront;
                                          });
                                          _audioPlayer.play(
                                              vocabData[index].sound.toString());
                                        },
                                        child: isFront
                                            ? FrontFlashCard(
                                                vocab: vocabData[index])
                                            : BackFlashCard(
                                                vocab: vocabData[index])),
                                    SizedBox(
                                      height: 50,
                                    ),
                                    SizedBox(
                                      width: 220,
                                      height: 60,
                                      child: ElevatedButton(
                                          onPressed: isFront
                                              ? null
                                              : () => handleNextPage(
                                                  vocabData[index].word,
                                                  vocabData[index].sound),
                                          style: ButtonStyle(
                                            backgroundColor: MaterialStateProperty.all(Color(0xFF21B6A8)),
                                              shape: MaterialStateProperty.all(
                                                  RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(32),
                                          ))),
                                          child: Text("Next", style: TextStyle(fontWeight: FontWeight.w600, fontSize: 18),)),
                                    )
                                  ],
                                );
                        }),
                  ),
              ),
    );
  }
}
