import 'package:fall_in_love_with_beauty/product/model/designer_model.dart';
import 'package:fall_in_love_with_beauty/product/model/product_model.dart';

enum ReservationStatus {
  ready('예약중'),
  done('예약완료'),
  end('시술완료');

  const ReservationStatus(this.label);

  final String label;
}

class ReservationModel {
  final String id;
  final ProductModel product;
  final DesignerModel designer;
  final String result;
  final ReservationStatus status;
  final DateTime createdAt;

  ReservationModel({
    required this.id,
    required this.product,
    required this.designer,
    required this.result,
    required this.status,
    required this.createdAt,
  });

  ReservationModel copyWith({
    String? id,
    ProductModel? product,
    DesignerModel? designer,
    String? result,
    ReservationStatus? status,
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
