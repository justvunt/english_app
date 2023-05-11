import 'package:audioplayers/audioplayers.dart';
import 'package:do_it/model/vocab_model.dart';
import 'package:flutter/material.dart';

class BackFlashCard extends StatelessWidget {
  final Vocab vocab;
  // const BackFlashCard({super.key});
  const BackFlashCard({Key? key, required this.vocab}) : super(key: key);

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
        // crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                vocab.word.toString(),
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    fontSize: 25),
              ),
              IconButton(
                  onPressed: () async {
                    AudioPlayer audioPlayer = AudioPlayer();
                    audioPlayer.play(vocab.sound.toString());
                  },
                  icon: Icon(
                    Icons.volume_up,
                    color: Colors.white,
                  ))
            ],
          ),
          SizedBox(height: 10),
          Text(
            vocab.pronunciation != null
                ? vocab.pronunciation.toString()
                : "",
            style: TextStyle(color: Colors.white, fontSize: 18),
          ),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 21.0),
            child: Text(
              vocab.vn.toString(),
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
