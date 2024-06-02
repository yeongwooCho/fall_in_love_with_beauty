import 'package:fall_in_love_with_beauty/common/const/image_path.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/designer_model.dart';
import '../model/product_model.dart';

final productsWithLikeProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(productProvider);
  return products.where((element) => element.isLike).toList();
});

final productDetailProvider = Provider.family<ProductModel, String>((ref, id) {
  final product =
      ref.watch(productProvider).firstWhere((element) => element.id == id);
  return product;
});

final productProvider =
    StateNotifierProvider<ProductStateNotifier, List<ProductModel>>((ref) {
  return ProductStateNotifier(ref: ref);
});

class ProductStateNotifier extends StateNotifier<List<ProductModel>> {
  final Ref ref;

  ProductStateNotifier({
    required this.ref,
  }) : super([]) {
    state = getItems();
  }

  void updateLike({
    required String id,
    required bool isLike,
  }) {
    state = state.map((element) {
      if (element.id == id) {
        return element.copyWith(isLike: isLike);
      } else {
        return element;
      }
    }).toList();
  }

  List<ProductModel> getItems() {
    final products = [
      '프레쉬 샐러드 보울',
      '야외 핫팟 피에스타',
      "프레쉬 야채 플래터",
      "헬시 믹스 샐러드",
      "비타민 가득 샐러드",
      "그릴드 치킨 닭가슴살 샐러드",
      "신선한 샐러드 보울",
      "허브 비프 스튜",
    ];

    final designers = ref.read(designerWithRandomProvider);

    return List.generate(
      products.length,
      (index) => ProductModel(
        id: index.toString(),
        name: products[index],
        mainImageUrl: '${ImagePath.productDirectory}$index.png',
        ratingPoint: DataUtils.getRandomDouble(min: 4, range: 1),
        hours: '11:00 ~ 20:00',
        location: '서울특별시 종로구 세종대로 172',
        isLike: DataUtils.getRandomBool(),
        designers: designers,
      ),
    );
  }
}
