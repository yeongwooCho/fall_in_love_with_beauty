import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/reserve_model.dart';

final reserveProvider =
    StateNotifierProvider<ReserveStateNotifier, List<ReserveModel>>(
  (ref) => ReserveStateNotifier(),
);

class ReserveStateNotifier extends StateNotifier<List<ReserveModel>> {
  ReserveStateNotifier() : super([]);
}
