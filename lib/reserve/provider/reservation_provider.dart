import 'package:fall_in_love_with_beauty/common/const/data.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
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

  void addReservation({
    required ReservationModel reservation,
  }) {
    state = [
      ...state,
      reservation,
    ];
  }

  void updateReservationResult({
    required String id,
    required String result,
  }) {
    state = state.map((e) {
      if (e.id == id) {
        return e.copyWith(
          result: result,
          status: ReservationStatus.done,
        );
      } else {
        return e;
      }
    }).toList();
  }

  void updateCreatedAt({
    required String id,
    required DateTime createdAt,
  }) {
    state = state.map((e) {
      if (e.id == id) {
        return e.copyWith(createdAt: createdAt);
      } else {
        return e;
      }
    }).toList();
  }

  void deleteReservation({
    required String id,
  }) {
    state = state.where((element) => element.id != id).toList();
  }

  List<ReservationModel> getItems() {
    return List.generate(
      12,
      (index) {
        final productIndex = DataUtils.getRandomInt(dividerNumber: 16);
        final designerIndex = DataUtils.getRandomInt(dividerNumber: 16);

        final product = ref.read(
          productDetailProvider(productIndex.toString()),
        );
        final designer = ref.read(
          designerDetailProvider(designerIndex.toString()),
        );

        final randomMonth = DataUtils.getRandomInt(dividerNumber: 6);
        final randomDay = DataUtils.getRandomInt(dividerNumber: 28);
        final randomHour = DataUtils.getRandomInt(dividerNumber: 8) + 12;

        List<String> results = [];
        kindOfResult.values.map((e) => results.addAll(e.keys)).toList();
        results.shuffle();

        return ReservationModel(
          id: index.toString(),
          product: product,
          designer: designer,
          result: results[0],
          createdAt: DateTime(2024, randomMonth, randomDay, randomHour, 0),
          status: ReservationStatus.end,
        );
      },
    );
  }
}
