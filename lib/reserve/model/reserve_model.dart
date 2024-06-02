import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';

class ReserveModel {
  final String id;
  final ProductModel product;
  final DesignerModel designer;
  final DateTime createdAt;

  ReserveModel({
    required this.id,
    required this.product,
    required this.designer,
    required this.createdAt,
  });

  ReserveModel copyWith({
    String? id,
    ProductModel? product,
    DesignerModel? designer,
    DateTime? createdAt,
  }) {
    return ReserveModel(
      id: id ?? this.id,
      product: product ?? this.product,
      designer: designer ?? this.designer,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
