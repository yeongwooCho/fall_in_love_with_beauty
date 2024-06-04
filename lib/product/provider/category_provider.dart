import 'package:fall_in_love_with_beauty/product/model/product_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final categorySelectedProvider = StateProvider<CategoryStatus>(
  (ref) => CategoryStatus.values.first,
);
