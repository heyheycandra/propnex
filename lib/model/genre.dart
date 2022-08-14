class Genre {
  int? id;
  String? name;

  Genre({this.id, this.name});

  Genre.map(Map obj) {
    id = obj['id'];
    name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
