import 'designer_model.dart';

class ProductModel {
  final String id;
  final String name;
  final String mainImageUrl;
  final double ratingPoint;
  final String hours;
  final String location;
  final bool isLike;

  final List<DesignerModel> designers;

  ProductModel({
    required this.id,
    required this.name,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.hours,
    required this.location,
    required this.isLike,
    required this.designers,
  });

  ProductModel copyWith({
    String? id,
    String? name,
    String? mainImageUrl,
    double? ratingPoint,
    String? hours,
    String? location,
    bool? isLike,
    List<DesignerModel>? designers,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      mainImageUrl: mainImageUrl ?? this.mainImageUrl,
      ratingPoint: ratingPoint ?? this.ratingPoint,
      hours: hours ?? this.hours,
      location: location ?? this.location,
      isLike: isLike ?? this.isLike,
      designers: designers ?? this.designers,
    );
  }
}
