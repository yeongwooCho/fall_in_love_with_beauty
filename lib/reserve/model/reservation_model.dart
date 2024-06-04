import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';

class ReservationModel {
  final String id;
  final ProductModel product;
  final DesignerModel designer;
  final String result;
  final String status;
  final DateTime createdAt;

  ReservationModel({
    required this.id,
    required this.product,
    required this.designer,
    required this.result,
    this.status = '예약완료',
    required this.createdAt,
  });

  ReservationModel copyWith({
    String? id,
    ProductModel? product,
    DesignerModel? designer,
    String? result,
    String? status,
    DateTime? createdAt,
  }) {
    return ReservationModel(
      id: id ?? this.id,
      product: product ?? this.product,
      designer: designer ?? this.designer,
      result: result ?? this.result,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
