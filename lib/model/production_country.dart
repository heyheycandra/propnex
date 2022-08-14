class ProductionCountry {
  String? iso31661;
  String? name;

  ProductionCountry({this.iso31661, this.name});

  ProductionCountry.map(Map obj) {
    iso31661 = obj['iso_3166_1'];
    name = obj['name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['iso_3166_1'] = iso31661;
    data['name'] = name;
    return data;
  }
}
