class Person {
  final int id;
  final double popularity;
  final String name;
  final String profileImg;
  final String known;
//  final String overview;
//  final String rating;

  Person(
      this.id,
      this.popularity,
      this.name,
      this.profileImg,
      this.known,
//      this.overview,
//      this.rating,
      );

  Person.fromJson(Map<String, dynamic> json)
      : id = json["id"],
        popularity = json["popularity"],
        name = json["name"],
        profileImg = json["profile_path"],
        known = json["known_for_department"].toDouble();
//        overview = json["overview"],
//        rating = json["vote_average"]
}