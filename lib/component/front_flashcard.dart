import 'package:audioplayers/audioplayers.dart';
import 'package:do_it/model/vocab_model.dart';
import 'package:flutter/material.dart';

// class FrontFlashCard extends StatelessWidget {
//   final Vocab vocab;
//   const FrontFlashCard({Key? key, required this.vocab}) : super(key: key);

//   @override
//   void initState() {
//     super.initState();
//     onCreate('https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3');
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         // color: Color.fromARGB(255, 72, 40, 203),
//         width: MediaQuery.of(context).size.width * 0.8,
//         height: MediaQuery.of(context).size.height * 0.6,
//         decoration: const BoxDecoration(
//           color: Color.fromARGB(255, 103, 33, 243),
//           borderRadius: BorderRadius.all(Radius.circular(15)),
//         ),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             SizedBox(height: 20),
//             Image.network(
//               vocab.image.toString(),
//               width: 250,
//             ),
//             SizedBox(height: 50),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   vocab.word.toString(),
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontWeight: FontWeight.w700,
//                       fontSize: 22),
//                 ),
//                 IconButton(
//                     onPressed: () async {
//                       AudioPlayer audioPlayer = AudioPlayer();
//                       audioPlayer.play(vocab.sound.toString());
//                     },
//                     icon: Icon(
//                       Icons.volume_up,
//                       color: Colors.white,
//                     ))
//               ],
//             ),
//             // Text(vocabData[index].pronunciation != null ? vocabData[index].pronunciation.toString() : "",
//             // style: TextStyle(color: Colors.white, fontSize: 16),),
//             Padding(
//               padding:
//                   const EdgeInsets.symmetric(horizontal: 24.0, vertical: 21.0),
//               child: Text(
//                 vocab.example.toString(),
//                 style: TextStyle(color: Colors.white, fontSize: 16),
//               ),
//             ),
//           ],
//         ));
//   }
// }

class FrontFlashCard extends StatefulWidget {
  final Vocab vocab;
  const FrontFlashCard({Key? key, required this.vocab}) : super(key: key);

  @override
  State<FrontFlashCard> createState() => _FrontFlashCardState();
}

class _FrontFlashCardState extends State<FrontFlashCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
        // color: Color.fromARGB(255, 72, 40, 203),
        width: MediaQuery.of(context).size.width * 0.8,
        height: MediaQuery.of(context).size.height * 0.6,
        decoration: const BoxDecoration(
          color: Color.fromARGB(255, 103, 33, 243),
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            Image.network(
              widget.vocab.image.toString(),
              width: 250,
            ),
            SizedBox(height: 50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  widget.vocab.word.toString(),
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 23),
                ),
                IconButton(
                    onPressed: () async {
                      AudioPlayer audioPlayer = AudioPlayer();
                      audioPlayer.play(widget.vocab.sound.toString());
                    },
                    icon: Icon(
                      Icons.volume_up,
                      color: Colors.white,
                    ))
              ],
            ),
            Text(
              widget.vocab.pronunciation.toString(),
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
            // Text(widget.vocabData[index].pronunciation != null ? widget.vocabData[index].pronunciation.toString() : "",
            // style: TextStyle(color: Colors.white, fontSize: 16),),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 24.0, vertical: 21.0),
              child: Text(
                widget.vocab.example.toString(),
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ));
  }
}
