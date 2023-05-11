import 'package:do_it/model/vocab_model.dart';
import 'package:flutter/material.dart';

class FreeFill extends StatefulWidget {
  final Vocab? vocab;
  final Function? setRevise;
  // const FreeFill({Key? key, required this.setRevise, required this.vocab}) : super(key: key);
  FreeFill({this.vocab, this.setRevise});

  @override
  State<FreeFill> createState() => _FreeFillState();
}

class _FreeFillState extends State<FreeFill> {
  String freeTextValue = "";
  final FocusNode _textFieldFocusNode = FocusNode();


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
                            _textFieldFocusNode.unfocus();
                            Navigator.pop(context);
                            widget.setRevise!.call("R");
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
                          try {
                            _textFieldFocusNode.unfocus();
                            Navigator.pop(context);
                            FocusScope.of(context).unfocus();
                            widget.setRevise!.call("W");
                          } catch (e) {
                            print(e);
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
  void dispose() {
    // Dispose of the FocusNode when the widget is disposed
    _textFieldFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 30,
        ),
        Text("Enter the word that heard", style: TextStyle(fontSize: 21, fontWeight: FontWeight.w500),),
        SizedBox(
          height: 30,
        ),
        TextField(
          focusNode: _textFieldFocusNode,
          strutStyle: StrutStyle(height: 2),
          style: TextStyle(fontSize: 21),
          onChanged: (value) {
            setState(() {
              freeTextValue = value;
            });
          },
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        SizedBox(
          width: 220,
          height: 60,
          child: ElevatedButton(
            onPressed: freeTextValue != ""
                ? () => handleContinue(freeTextValue,
                    widget.vocab!.word.toString(), widget.vocab!.vn.toString())
                : null,
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Color(0xFF21B6A8)),
              shape: MaterialStateProperty.all(RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(32),
              )),
            ),
            child: const Text(
              "Check",
              style: TextStyle(fontSize: 21),
            ),
          ),
        )
      ],
    );
  }
}
