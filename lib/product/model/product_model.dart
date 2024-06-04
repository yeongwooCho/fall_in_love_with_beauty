import 'designer_model.dart';

enum CategoryStatus {
  all('전체'),
  beauty('미용'),
  nail('네일'),
  eyebrow('(속)눈썹'),
  waxing('왁싱');

  const CategoryStatus(this.label);

  final String label;
}

class ProductModel {
  final String id;
  final String name;
  final String mainImageUrl;
  final double ratingPoint;
  final String hours;
  final String location;
  final bool isLike;

  final CategoryStatus categoryStatus;
  final List<DesignerModel> designers;

  ProductModel({
    required this.id,
    required this.name,
    required this.mainImageUrl,
    required this.ratingPoint,
    required this.hours,
    required this.location,
    required this.isLike,
    required this.categoryStatus,
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
    CategoryStatus? categoryStatus,
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
      categoryStatus: categoryStatus ?? this.categoryStatus,
      designers: designers ?? this.designers,
    );
  }
}
