class Vocab {
  String? id;
  String? word;
  String? vn;
  String? en;
  String? pronunciation;
  String? sound;
  String? image;
  String? example;
  String? setId;
  int? level;

  Vocab(
      {this.id,
      this.word,
      this.vn,
      this.en,
      this.pronunciation,
      this.sound,
      this.image,
      this.example,
      this.setId,
      this.level});

  Vocab.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    word = json['word'];
    vn = json['vn'];
    en = json['en'];
    pronunciation = json['pronunciation'];
    sound = json['sound'];
    image = json['image'];
    example = json['example'];
    setId = json['setId'];
    level = json['level'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['word'] = this.word;
    data['vn'] = this.vn;
    data['en'] = this.en;
    data['pronunciation'] = this.pronunciation;
    data['sound'] = this.sound;
    data['image'] = this.image;
    data['example'] = this.example;
    data['setId'] = this.setId;
    data['level'] = this.level;
    return data;
  }
}