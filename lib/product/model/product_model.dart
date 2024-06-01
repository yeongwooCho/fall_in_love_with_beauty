class ProductModel {
  final int id;
  final String name;
  final String mainImageUrl;
  final double ratingPoint;
  final String hours;
  final String location;
  final bool isLike;

  ProductModel({
    required this.id,
    required this.name,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.hours,
    required this.location,
    required this.isLike,
  });

  ProductModel copyWith({
    int? id,
    String? name,
    String? mainImageUrl,
    double? ratingPoint,
    String? hours,
    String? location,
    bool? isLike,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      ratingPoint: ratingPoint ?? this.ratingPoint,
      hours: hours ?? this.hours,
      location: location ?? this.location,
      isLike: isLike ?? this.isLike,
    );
  }
}
