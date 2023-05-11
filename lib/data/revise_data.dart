import 'package:do_it/model/vocab_model.dart';

List<Vocab> vocabs = [
  Vocab(
    en: "More than half (50%) of some group.",
    example: "The majority of the group wanted to try the new Chinese restaurant.",
    id: "b991041b-fb66-430e-be7c-01f39fbb0425",
    image: "http://www.voca.vn/assets/assets-v2/img/library/majority.jpg",
    pronunciation: "/məˈd͡ʒɑɹɪti/",
    setId: "e275437c-296e-4468-be00-68cdab79f7c4",
    sound: "https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/aemhwb6t616j8jfuqrpuyuaexjlbhuega5xbt43nc.mp3",
    vn: "phần lớn, đa số",
    word: "majority",
  ),

  Vocab(
    en:"The act or process of guiding.",
    example: "The helpline was set up for young people in need of guidance.",
    id: "cd6fa8fb-5460-489e-b6a3-0622c768bfb3",
    image: "http://www.voca.vn/assets/assets-v2/img/library/guide%20(1).jpg",
    pronunciation: null,
    setId: "e275437c-296e-4468-be00-68cdab79f7c4",
    sound: "https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/fsohmzpakqm52lp9j9ldnzirxjqdls1vhnktpcet8.mp3",
    vn: "hướng dẫn, trợ giúp",
    word: "guidance"
  ),

  Vocab(
    en:"The act of mixing.",
    example:"The walls were built using a mixture of water, rock, and dirt.",
    id:"c423212b-e65b-4a4f-a499-0f6ef832b335",
    image:"http://www.voca.vn/assets/assets-v2/img/library/mixture.jpg",
    pronunciation:"/ˈmɪkstʃɚ/",
    setId:"e275437c-296e-4468-be00-68cdab79f7c4",
    sound:"https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/nr8kxdke3olcnrdp66v8odxhqoderwamkfd4vg9jo4.mp3",
    vn:"hỗn hợp",
    word:"mixture",
  ),

  Vocab(
    en:"To stir together.",
    example:"The chef is mixing two ingredients very carefully.",
    id:"ffe94dee-d21d-466b-a182-38ad0234d1e6",
    image:"http://www.voca.vn/assets/assets-v2/img/library/mix.jpg",
    pronunciation:null,
    setId:"e275437c-296e-4468-be00-68cdab79f7c4",
    sound:"https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/m66svwmngsog18hsou3bmhuxlnys0mcdbfmgiblfqq.mp3",
    vn:"trộn, hòa lẫn",
    word:"mix",
  ),

  Vocab(
    en:"To make safe; to relieve from apprehensions of, or exposure to, danger; to guard; to protect.",
    example:"The waiter secured us a table next to the windows.",
    id:"1f209f00-7e62-44b1-9660-4eba9090cd4f",
    image:"http://www.voca.vn/assets/assets-v2/img/library/secure_3.jpg",
    pronunciation:"/səˈkjɔɹ/",
    setId:"e275437c-296e-4468-be00-68cdab79f7c4",
    sound:"https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/ikx4n1aljogdkl8x0w8mrh1vckc8d6jd5phgupepmr4.mp3",
    vn:"giành được, đạt được",
    word:"secure",
  ),

  Vocab(
    en:"To make safe; to relieve from apprehensions of, or exposure to, danger; to guard; to protect.",
    example:"The waiter secured us a table next to the windows.",
    id:"1f209f00-7e62-44b1-9660-4eba9090cd4f",
    image:"http://www.voca.vn/assets/assets-v2/img/library/secure_3.jpg",
    pronunciation:"/səˈkjɔɹ/",
    setId:"e275437c-296e-4468-be00-68cdab79f7c4",
    sound:"https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/ikx4n1aljogdkl8x0w8mrh1vckc8d6jd5phgupepmr4.mp3",
    vn:"giành được, đạt được",
    word:"secure",
  ),

  Vocab(
    en:"Mutual good, shared by more than one.",
    example:"Money worries are a common problem for people raising children.",
    id:"31b670dd-9645-4e78-ac59-bebc413c59ff",
    image:"http://www.voca.vn/assets/assets-v2/img/library/common.jpg",
    pronunciation:"/ˈkɑmən/",
    setId:"e275437c-296e-4468-be00-68cdab79f7c4",
    sound:"https://www.voca.vn/word-sound/cfcd208495d565ef66e7dff9f98764da/nrzgwm2h2hpdle6yxdhfc5u29pyrimqlbj67u21g61m.mp3",
    vn:"phổ biến, thông thường",
    word:"common",
  )
];



List<String> quiz_types = ['VE', 'EV', 'fill_in_gap', "fill_letter"];

List<String> multiple_ve(Vocab vocab, List<Vocab> vocabList){
  vocabList.shuffle();
  List<String> choices = [vocab.word.toString()];
  if(vocabList.length < 5){
    for(int i=0; i<5; i++){
        if(vocabList[i].id.toString() == vocab.id.toString()) continue;
        choices.add(vocabList[i].word.toString());
    }
  }
  else{
    int i = 0;
    while(choices.length != 4){
      if(vocabList[i].id.toString() == vocab.id.toString()) continue;
      choices.add(vocabList[i].word.toString());
      i+=1;
    }
  }
  choices.shuffle();
  return choices;
}

List<String> multiple_ev(Vocab vocab, List<Vocab> vocabList){
  vocabList.shuffle();
  List<String> choices = [vocab.vn.toString()];
  if(vocabList.length < 5){
    for(int i=0; i<5; i++){
        if(vocabList[i].id.toString() == vocab.id.toString()) continue;
        choices.add(vocabList[i].vn.toString());
    }
  }
  else{
    int i = 0;
    while(choices.length != 4){
      if(vocabList[i].id.toString() == vocab.id.toString()) continue;
      choices.add(vocabList[i].vn.toString());
      i+=1;
    }
  }
  choices.shuffle();
  return choices;
}

String fill_in_gap(int index, Vocab vocab){
  List<String> words = vocab.example.toString().split(" ");
  words[index] = "_ _ _ _ _ ";
  return words.join(" ");
}
