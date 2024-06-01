import 'package:flutter_riverpod/flutter_riverpod.dart';

final categorySelectedProvider = StateProvider<String>(
  (ref) => '전체',
);

final categoriesProvider = StateProvider<List<String>>(
  (ref) => [
    '미용',
    '네일',
    '(속)눈썹',
    '왁싱',
  ],
);
