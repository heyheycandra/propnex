class SpokenLanguage {
  String? englishName;
  String? iso6391;
  String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  SpokenLanguage.map(Map obj) {
    englishName = obj['english_name'];
    iso6391 = obj['iso_639_1'];
    name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['english_name'] = englishName;
    data['iso_639_1'] = iso6391;
    data['name'] = name;
    return data;
  }
}
