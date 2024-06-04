import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/reserve_model.dart';

final reserveDetailProvider = Provider.family<ReserveModel, String>((ref, id) {
  final reservation =
      ref.watch(reserveProvider).firstWhere((element) => element.id == id);
  return reservation;
});

final reserveProvider =
    StateNotifierProvider<ReserveStateNotifier, List<ReserveModel>>(
  (ref) => ReserveStateNotifier(ref: ref),
);

class ReserveStateNotifier extends StateNotifier<List<ReserveModel>> {
  Ref ref;

  ReserveStateNotifier({
    required this.ref,
  }) : super([]) {
    state = getItems();
  }

  void deleteReservation({
    required String id,
  }) {
    state = state.where((element) => element.id != id).toList();
  }

  List<ReserveModel> getItems() {
    final product = ref.read(
      productDetailProvider('1'),
    );
    final designer = ref.read(
      designerDetailProvider('1'),
    );

    return List.generate(
      20,
      (index) => ReserveModel(
        id: index.toString(),
        product: product,
        designer: designer,
        createdAt: DateTime(2024, index, 15),
      ),
    );
  }
}
