import 'package:technical_take_home/model/genre.dart';
import 'package:technical_take_home/model/production_company.dart';
import 'package:technical_take_home/model/production_country.dart';
import 'package:technical_take_home/model/sp_language.dart';

class Movie {
  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  int? id;
  String? strId;
  String? originalLanguage;
  String? originalTitle;
  String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  String? title;
  bool? video;
  dynamic voteAverage;
  int? voteCount;
  dynamic belongsToCollection;
  int? budget;
  List<Genre>? genres;
  String? homepage;
  String? imdbId;
  List<ProductionCompany>? productionCompanies;
  List<ProductionCountry>? productionCountries;
  int? revenue;
  int? runtime;
  List<SpokenLanguage>? spokenLanguages;
  String? status;
  String? tagline;
  String? firstAirDate;
  String? name;
  List<String>? originCountry;
  String? originalName;

  Movie(
      {this.adult,
      this.backdropPath,
      this.genreIds,
      this.id,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.belongsToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.imdbId,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runtime,
      this.spokenLanguages,
      this.status,
      this.tagline,
      this.firstAirDate,
      this.name,
      this.strId,
      this.originCountry,
      this.originalName});

  Movie.map(Map obj) {
    adult = obj['adult'];
    backdropPath = obj['backdrop_path'];
    dynamic genreIdList = obj['genre_ids'];
    if (genreIdList is List) {
      genreIds = [];
      for (var item in genreIdList) {
        if (item is int) {
          genreIds!.add(item);
        }
      }
    }
    id = obj['id'];
    originalLanguage = obj['original_language'];
    originalTitle = obj['original_title'];
    overview = obj['overview'];
    popularity = obj['popularity'];
    posterPath = obj['poster_path'];
    releaseDate = obj['release_date'];
    title = obj['title'];
    video = obj['video'];
    voteAverage = obj['vote_average'];
    voteCount = obj['vote_count'];
    belongsToCollection = obj['belongs_to_collection'];
    budget = obj['budget'];
    dynamic objGenre = obj['genres'];
    if (objGenre is List) {
      genres = [];
      for (var element in objGenre) {
        if (element is Map) {
          genres!.add(Genre.map(element));
        }
      }
    }
    homepage = obj['homepage'];
    imdbId = obj['imdb_id'];
    dynamic objCompanies = obj['production_companies'];
    if (objCompanies is List) {
      productionCompanies = [];
      for (var element in objCompanies) {
        if (element is Map) {
          productionCompanies!.add(ProductionCompany.map(element));
        }
      }
    }
    dynamic objCountries = obj['production_countries'];
    if (objCountries is List) {
      productionCountries = [];
      for (var element in objCountries) {
        if (element is Map) {
          productionCountries!.add(ProductionCountry.map(element));
        }
      }
    }
    revenue = obj['revenue'];
    runtime = obj['runtime'];
    dynamic objLanguages = obj['spoken_languages'];
    if (objLanguages is List) {
      spokenLanguages = [];
      for (var element in objLanguages) {
        if (element is Map) {
          spokenLanguages!.add(SpokenLanguage.map(element));
        }
      }
    }
    status = obj['status'];
    tagline = obj['tagline'];
    firstAirDate = obj['first_air_date'];
    name = obj['name'];
    dynamic listOriginCountries = obj['origin_country'];
    if (listOriginCountries is List) {
      originCountry = [];
      for (var item in listOriginCountries) {
        if (item is String) {
          originCountry!.add(item);
        }
      }
    }
    originalName = obj['original_name'];
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = {};
    data['adult'] = adult;
    data['backdrop_path'] = backdropPath;
    data['genre_ids'] = genreIds;
    data['id'] = id;
    data['original_language'] = originalLanguage;
    data['original_title'] = originalTitle;
    data['overview'] = overview;
    data['popularity'] = popularity;
    data['poster_path'] = posterPath;
    data['release_date'] = releaseDate;
    data['title'] = title;
    data['video'] = video;
    data['vote_average'] = voteAverage;
    data['vote_count'] = voteCount;
    data['belongs_to_collection'] = belongsToCollection;
    data['budget'] = budget;
    if (genres != null) {
      data['genres'] = genres!.map((v) => v.toMap()).toList();
    }
    data['homepage'] = homepage;
    data['imdb_id'] = imdbId;
    if (productionCompanies != null) {
      data['production_companies'] = productionCompanies!.map((v) => v.toMap()).toList();
    }
    if (productionCountries != null) {
      data['production_countries'] = productionCountries!.map((v) => v.toMap()).toList();
    }
    data['revenue'] = revenue;
    data['runtime'] = runtime;
    if (spokenLanguages != null) {
      data['spoken_languages'] = spokenLanguages!.map((v) => v.toMap()).toList();
    }
    data['status'] = status;
    data['tagline'] = tagline;
    data['first_air_date'] = firstAirDate;
    data['name'] = name;
    data['origin_country'] = originCountry;
    data['original_name'] = originalName;
    return data;
  }
}
