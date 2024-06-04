import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';

class ReservationModel {
  final String id;
  final ProductModel product;
  final DesignerModel designer;
  final DateTime createdAt;

  ReservationModel({
    required this.id,
    required this.product,
    required this.designer,
    required this.createdAt,
  });

  ReservationModel copyWith({
    String? id,
    ProductModel? product,
    DesignerModel? designer,
    DateTime? createdAt,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      product: product ?? this.product,
      designer: designer ?? this.designer,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
