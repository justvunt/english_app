class Quiz {
  String? word;
  String? ans;
  String? pronunc;
  String? image;
  String? quizType;
  String? en;
  List<String>? choices;

  Quiz(
      {this.word,
      this.ans,
      this.pronunc,
      this.image,
      this.quizType,
      this.en,
      this.choices});

  Quiz.fromJson(Map<String, dynamic> json) {
    word = json['word'];
    ans = json['ans'];
    pronunc = json['pronunc'];
    image = json['image'];
    quizType = json['quizType'];
    en = json['en'];
    if(json['choices'] != null){
        choices = json['choices'].cast<String>();
    }
    
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['word'] = this.word;
    data['ans'] = this.ans;
    data['pronunc'] = this.pronunc;
    data['image'] = this.image;
    data['quizType'] = this.quizType;
    data['en'] = this.en;
    data['choices'] = this.choices;
    return data;
  }
}