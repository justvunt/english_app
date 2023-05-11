import 'package:audioplayers/audioplayers.dart';
import 'package:do_it/model/vocab_model.dart';
import 'package:flutter/material.dart';

class MultipleChoices extends StatefulWidget {
  final Vocab vocab;
  final List<Vocab> vocabList;
  final String type;
  final Function setDisplay;
  MultipleChoices({
    Key? key,
    required this.vocab,
    required this.vocabList,
    required this.type,
    required this.setDisplay,
  }) : super(key: key);

  @override
  State<MultipleChoices> createState() => _MultipleChoicesState();
}

class _MultipleChoicesState extends State<MultipleChoices> {
  List<String> generateTest(Vocab vocab, List<Vocab> vocabList) {
    vocabList.shuffle();
    List<String> choices = [];
    if (widget.type == "VE") {
      choices.add(vocab.word!);
      if (vocabList.length < 5) {
        for (int i = 0; i < vocabList.length; i++) {
          if (vocabList[i].id.toString() == vocab.id.toString()) continue;
          choices.add(vocabList[i].word!);
        }
      } else {
        int i = 0;
        while (choices.length != 4) {
          if (vocabList[i].id.toString() == vocab.id.toString()) {
            i += 1;
            continue;
          }
          ;
          choices.add(vocabList[i].word!);
          i += 1;
        }
      }
    } else {
      choices.add(vocab.vn!);
      if (vocabList.length < 5) {
        for (int i = 0; i < vocabList.length; i++) {
          if (vocabList[i].id.toString() == vocab.id.toString()) continue;
          choices.add(vocabList[i].vn.toString());
        }
      } else {
        int i = 0;
        while (choices.length != 4) {
          if (vocabList[i].id.toString() == vocab.id.toString()) {
            i += 1;
            continue;
          }
          ;
          choices.add(vocabList[i].vn.toString());
          i += 1;
        }
      }
    }

    choices.shuffle();
    return choices;
  }

  List<String> choices = [];
  bool isPressed = false;
  Color mainColor = Color(0xFF21B6A8);
  Color textColor = Colors.white;
  Color rightColor = Color.fromARGB(255, 15, 171, 64);
  Color wrongColor = Color.fromARGB(255, 255, 54, 40);
  Color btnColor = Color.fromARGB(255, 255, 255, 255);
  String mainWord = "";
  String ans = "";
  bool isTrue = false;
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void initState() {
    super.initState();
    if(widget.type != "VE"){
    _audioPlayer.play(widget.vocab.sound.toString());
    }
    setState(() {
      choices = generateTest(widget.vocab, widget.vocabList);
    });
    if (widget.type == "VE") {
      choices = generateTest(widget.vocab, widget.vocabList);
      setState(() {
        mainWord = widget.vocab.vn!;
        ans = widget.vocab.word!;
      });
    } else {
      choices = generateTest(widget.vocab, widget.vocabList);
      setState(() {
        mainWord = widget.vocab.word!;
        ans = widget.vocab.vn!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    // return Center(child: Text("Content"),);
    return Column(
      children: [
        // Text("Question 1/2"),
        Container(
          width: double.infinity,
          height: 150,
          color: mainColor,
          child: Center(
            child: Text(
              mainWord,
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                  color: Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
        for (int i = 0; i < choices.length; i++)
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            margin: EdgeInsets.only(bottom: 21.0),
            child: SizedBox(
              height: 55,
              child: ElevatedButton(
                onPressed: isPressed
                    ? () => {}
                    : () {
                        if (choices[i] == ans) {
                          setState(() {
                            isTrue = true;
                          });
                        }
                        ;
                        setState(() {
                          isPressed = true;
                        });
                      },
                style: ButtonStyle(
                  backgroundColor: isPressed
                      ? choices[i] == ans
                          ? MaterialStateProperty.all<Color>(rightColor)
                          : MaterialStateProperty.all<Color>(wrongColor)
                      : MaterialStateProperty.all<Color>(btnColor),
                  shape: MaterialStateProperty.all(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                      side: BorderSide(
                          width: 1, color: Color.fromARGB(255, 173, 169, 169)),
                    ),
                  ),
                ),
                child: Text(
                  choices[i],
                  style: TextStyle(color: Color(0xFF2B2B2B), fontSize: 18),
                ),
              ),
            ),
          ),
        SizedBox(
          height: 20,
        ),
        SizedBox(
          height: 60,
          width: 200,
          child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(mainColor),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50.0),
                    side: BorderSide(
                        width: 1, color: Color.fromARGB(255, 173, 169, 169)),
                  ),
                ),
              ),
              onPressed: () {
                if (isTrue) {
                  widget.setDisplay.call("R", vocab: widget.vocab);
                } else {
                  widget.setDisplay.call("W", vocab: widget.vocab);
                }
              },
              child: Text(
                "Next question",
                style: TextStyle(fontSize: 18),
              )),
        )
      ],
    );
  }
}
