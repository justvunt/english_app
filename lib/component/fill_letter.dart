import 'package:audioplayers/audioplayers.dart';
import 'package:do_it/component/free_fill.dart';
import 'package:do_it/model/vocab_model.dart';
import 'package:flutter/material.dart';

class FillLetter extends StatefulWidget {
  final Vocab? vocab;
  final Function? setDisplay;
  FillLetter({this.vocab, this.setDisplay});
  // FillLetter({
  //   Key? key,
  //   required this.setDisplay,
  //   required this.vocab,
  // }) : super(key: key);

  @override
  State<FillLetter> createState() => _FillLetterState();
}

class _FillLetterState extends State<FillLetter> {
  final TextEditingController _answerController = TextEditingController();
  bool isContinue = false;
  AudioPlayer _audioPlayer = AudioPlayer();
  String textWord = "";
  int wordSize = 0;
  String word = "";

  bool isLast = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _audioPlayer.play(widget.vocab!.sound.toString());
    setState(() {
      word = widget.vocab!.word.toString().toLowerCase();
      textWord = '_' * word.length;
      wordSize = word.length;
      _answerController.text = textWord;
    });
  }

  void handleTextChange(value) {
    value = value.toString().toLowerCase();
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
          _answerController.text = textWord.toLowerCase();
          _answerController.selection =
              TextSelection.collapsed(offset: wordSize);
        });
      } else {
        setState(() {
          textWord = textWord.replaceFirst('_', letter, index);
          _answerController.text = textWord.toLowerCase();
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
        _answerController.text = textWord.toLowerCase();
        _answerController.selection = TextSelection.collapsed(offset: wordSize);
      });
    }
  }

  void handleContinue(
      String typedValue, String ans, String vn, var parentContext,
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
                            Navigator.pop(context);
                            setState(() {
                              isLast = true;
                            });
                            if (soundUrl != "") {
                              _audioPlayer.play(soundUrl);
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
                            Navigator.pop(context);
                            setState(() {
                              isLast = true;
                            });
                            if (soundUrl != "") {
                              _audioPlayer.play(soundUrl);
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
    return isLast
        ? FreeFill(setRevise: widget.setDisplay, vocab: widget.vocab)
        : Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          const SizedBox(
              height: 21,
            ),
            Text(
              widget.vocab!.vn.toString(),
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 32,
            ),
            TextField(
              controller: _answerController,
              showCursor: false,
              textAlign: TextAlign.center,
              strutStyle: StrutStyle(height: 2),
              style: const TextStyle(
                  fontSize: 21,
                  letterSpacing: 8.0,
                  fontWeight: FontWeight.w500),
              onChanged: (value) => handleTextChange(value),
              // ignore: prefer_const_constructors
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            SizedBox(
              width: 220,
              height: 60,
              child: ElevatedButton(
                onPressed: isContinue
                    ? () => handleContinue(
                        textWord,
                        widget.vocab!.word.toString(),
                        widget.vocab!.vn.toString(),
                        soundUrl: widget.vocab!.sound.toString(),
                        context)
                    : null,
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Color(0xFF21B6A8)),
                  shape: MaterialStateProperty.all(RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                  )),
                ),
                child: const Text(
                  "Check",
                  style: TextStyle(fontSize: 21, color: Colors.white),
                ),
              ),
            )
          ]);
  }
}
