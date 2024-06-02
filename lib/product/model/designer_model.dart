class DesignerModel {
  final String id;
  final String name;
  final String thumbnail;
  final String mainImageUrl;
  final double ratingPoint;
  final String description;
  final String snsUrl;
  final bool isLike;

  final List<String> resultImageUrls;

  DesignerModel({
    required this.id,
    required this.name,
    required this.thumbnail,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.description,
    required this.snsUrl,
    required this.isLike,
    required this.resultImageUrls,
  });

  DesignerModel copyWith({
    String? id,
    String? name,
    String? thumbnail,
    String? mainImageUrl,
    double? ratingPoint,
    String? description,
    String? snsUrl,
    bool? isLike,
    List<String>? resultImageUrls,
  }) {
    return DesignerModel(
      id: id ?? this.id,
      name: name ?? this.name,
      thumbnail: thumbnail ?? this.thumbnail,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      ratingPoint: ratingPoint ?? this.ratingPoint,
      description: description ?? this.description,
      snsUrl: snsUrl ?? this.snsUrl,
      isLike: isLike ?? this.isLike,
      resultImageUrls: resultImageUrls ?? this.resultImageUrls,
    );
  }
}
