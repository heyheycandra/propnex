// import 'package:technical_take_home/helper/app_exception.dart';
import 'package:technical_take_home/services/api_url.dart';
import 'package:technical_take_home/services/net_util.dart';

class RestApi extends UrlApi {
  NetworkUtil util = NetworkUtil();

  Future<dynamic> movieNowPlaying({required Map<String, String> param}) {
    return util
        .get(
      movie + "/now_playing",
      // headers: {
      //   'accept': 'aplication/json',
      //   'Content-Type': 'application/json;charset=utf-8',
      // },
      param: param,
    )
        .then((value) {
      return value;
    });
  }

  Future<dynamic> movieSearch({required Map<String, String> param}) {
    return util
        .get(
      search + "/movie",
      // headers: {
      //   'accept': 'aplication/json',
      //   'Content-Type': 'application/json;charset=utf-8',
      // },
      param: param,
    )
        .then((value) {
      return value;
    });
  }

  Future<dynamic> moviePopular({required Map<String, String> param}) {
    return util
        .get(movie + "/popular",
            // headers: {
            //   'accept': 'aplication/json',
            //   'Content-Type': 'application/json;charset=utf-8',
            // },
            param: param)
        .then((value) {
      return value;
    });
  }

  Future<dynamic> movieRecom({required String movieId, required Map<String, String> param}) {
    return util
        .get(movie + "/$movieId/recommendations",
            // headers: {
            //   'accept': 'aplication/json',
            //   'Content-Type': 'application/json;charset=utf-8',
            // },
            param: param)
        .then((value) {
      return value;
    });
  }

  Future<dynamic> movieDetail({required String movieId, Map<String, String>? param}) {
    return util
        .get(movie + "/$movieId",
            // headers: {
            //   'accept': 'aplication/json',
            //   'Content-Type': 'application/json;charset=utf-8',
            // },
            param: param)
        .then((value) {
      return value;
    });
  }

  Future<dynamic> tvOnAir({required Map<String, String> param}) {
    return util
        .get(
      tv + "/on_the_air",
      // headers: {
      //   'accept': 'aplication/json',
      //   'Content-Type': 'application/json;charset=utf-8',
      // },
      param: param,
    )
        .then((value) {
      return value;
    });
  }

  Future<dynamic> tvSearch({required Map<String, String> param}) {
    return util
        .get(
      search + "/tv",
      // headers: {
      //   'accept': 'aplication/json',
      //   'Content-Type': 'application/json;charset=utf-8',
      // },
      param: param,
    )
        .then((value) {
      return value;
    });
  }

  Future<dynamic> tvPopular({required Map<String, String> param}) {
    return util
        .get(tv + "/popular",
            // headers: {
            //   'accept': 'aplication/json',
            //   'Content-Type': 'application/json;charset=utf-8',
            // },
            param: param)
        .then((value) {
      return value;
    });
  }

  Future<dynamic> tvRecom({required String tvId, required Map<String, String> param}) {
    return util
        .get(tv + "/$tvId/recommendations",
            // headers: {
            //   'accept': 'aplication/json',
            //   'Content-Type': 'application/json;charset=utf-8',
            // },
            param: param)
        .then((value) {
      return value;
    });
  }

  Future<dynamic> tvDetail({required String tvId, Map<String, String>? param}) {
    return util
        .get(tv + "/$tvId",
            // headers: {
            //   'accept': 'aplication/json',
            //   'Content-Type': 'application/json;charset=utf-8',
            // },
            param: param)
        .then((value) {
      return value;
    });
  }

  // Future<dynamic> getImage({required String path, Map<String, String>? param}) {
  //   return util
  //       .getImage(poster + "/$path",
  //           // headers: {
  //           //   'accept': 'aplication/json',
  //           //   'Content-Type': 'application/json;charset=utf-8',
  //           // },
  //           param: param)
  //       .then((value) {
  //     return value;
  //   });
  // }
}
