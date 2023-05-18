class MoviesListModel {
  List<Items>? items;
  String? errorMessage;

  MoviesListModel({this.items, this.errorMessage});

  MoviesListModel.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    errorMessage = json['errorMessage'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['errorMessage'] = this.errorMessage;
    return data;
  }
}

class Items {
  String? id;
  String? rank;
  String? title;
  String? fullTitle;
  String? year;
  String? image;
  String? crew;
  String? imDbRating;
  String? imDbRatingCount;

  Items(
      {this.id,
      this.rank,
      this.title,
      this.fullTitle,
      this.year,
      this.image,
      this.crew,
      this.imDbRating,
      this.imDbRatingCount});

  Items.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    rank = json['rank'];
    title = json['title'];
    fullTitle = json['fullTitle'];
    year = json['year'];
    image = json['image'];
    crew = json['crew'];
    imDbRating = json['imDbRating'];
    imDbRatingCount = json['imDbRatingCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['rank'] = this.rank;
    data['title'] = this.title;
    data['fullTitle'] = this.fullTitle;
    data['year'] = this.year;
    data['image'] = this.image;
    data['crew'] = this.crew;
    data['imDbRating'] = this.imDbRating;
    data['imDbRatingCount'] = this.imDbRatingCount;
    return data;
  }
}
