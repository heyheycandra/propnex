class ProductionCompany {
  int? id;
  String? logoPath;
  String? name;
  String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  ProductionCompany.map(Map obj) {
    id = obj['id'];
    logoPath = obj['logo_path'];
    name = obj['name'];
    originCountry = obj['origin_country'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['logo_path'] = logoPath;
    data['name'] = name;
    data['origin_country'] = originCountry;
    return data;
  }
}
