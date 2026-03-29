import 'package:kasir_1/services/url.dart' as url;

class MovieModel {
  final int? id;
  final String? title;
  final double? voteAverage;
  final String? overview;
  final String? posterPath;

  MovieModel({
    this.id,
    this.title,
    this.voteAverage,
    this.overview,
    this.posterPath,
  });

  /// JSON → MovieModel
  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json["id"],
      title: json["title"],
      voteAverage:
          double.tryParse(json["voteaverage"]?.toString() ?? ""),
      overview: json["overview"],
      posterPath: json["posterpath"] != null
          ? "${url.Baseurl}/${json["posterpath"]}"
          : null,
    );
  }
}