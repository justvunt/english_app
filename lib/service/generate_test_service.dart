import 'package:do_it/model/vocab_model.dart';

class GenereateTest {
  List<String> multiple_ve(Vocab vocab, List<Vocab> vocabList) {
    vocabList.shuffle();
    List<String> choices = [vocab.word.toString()];
    if (vocabList.length < 5) {
      for (int i = 0; i < 5; i++) {
        if (vocabList[i].id.toString() == vocab.id.toString()) continue;
        choices.add(vocabList[i].word.toString());
      }
    } else {
      int i = 0;
      while (choices.length != 4) {
        if (vocabList[i].id.toString() == vocab.id.toString()) continue;
        choices.add(vocabList[i].word.toString());
        i += 1;
      }
    }
    choices.shuffle();
    return choices;
  }

  List<String> multiple_ev(Vocab vocab, List<Vocab> vocabList) {
    vocabList.shuffle();
    List<String> choices = [vocab.vn.toString()];
    if (vocabList.length < 5) {
      for (int i = 0; i < 5; i++) {
        if (vocabList[i].id.toString() == vocab.id.toString()) continue;
        choices.add(vocabList[i].vn.toString());
      }
    } else {
      int i = 0;
      while (choices.length != 4) {
        if (vocabList[i].id.toString() == vocab.id.toString()) continue;
        choices.add(vocabList[i].vn.toString());
        i += 1;
      }
    }
    choices.shuffle();
    return choices;
  }

  String fill_in_gap(int index, Vocab vocab) {
    List<String> words = vocab.example.toString().split(" ");
    words[index] = "_ _ _ _ _ ";
    return words.join(" ");
  }
}
