import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/product_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/reservation_model.dart';

final reservationDetailProvider =
    Provider.family<ReservationModel, String>((ref, id) {
  final reservation =
      ref.watch(reservationProvider).firstWhere((element) => element.id == id);
  return reservation;
});

final reservationProvider =
    StateNotifierProvider<ReservationStateNotifier, List<ReservationModel>>(
  (ref) => ReservationStateNotifier(ref: ref),
);

class ReservationStateNotifier extends StateNotifier<List<ReservationModel>> {
  Ref ref;

  ReservationStateNotifier({
    required this.ref,
  }) : super([]) {
    state = getItems();
  }

  void deleteReservation({
    required String id,
  }) {
    state = state.where((element) => element.id != id).toList();
  }

  List<ReservationModel> getItems() {
    final product = ref.read(
      productDetailProvider('1'),
    );
    final designer = ref.read(
      designerDetailProvider('1'),
    );

    return List.generate(
      20,
      (index) => ReservationModel(
        id: index.toString(),
        product: product,
        designer: designer,
        createdAt: DateTime(2024, index, 15),
      ),
    );
  }
}
