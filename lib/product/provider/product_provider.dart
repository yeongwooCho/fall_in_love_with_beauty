import 'package:fall_in_love_with_beauty/common/const/image_path.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:fall_in_love_with_beauty/product/provider/category_provider.dart';
import 'package:fall_in_love_with_beauty/product/provider/designer_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/product_model.dart';

final productsWithCategoryProvider = Provider<List<ProductModel>>((ref) {
  final products = ref.watch(productProvider);
  final selectedCategory = ref.watch(categorySelectedProvider);

  if (selectedCategory == CategoryStatus.all) {
    return products;
  } else {
    final productsWithCategory =
        products.where((e) => e.categoryStatus == selectedCategory).toList();

    return productsWithCategory;
  }
});

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
    final Map<String, List<int>> products = {
      '프레쉬 샐러드 보울': [0, 1, 2],
      '야외 핫팟 피에스타': [3, 4],
      "프레쉬 야채 플래터": [5, 6],
      "헬시 믹스 샐러드": [7, 8, 9],
      "비타민 가득 샐러드": [10],
      "그릴드 치킨 닭가슴살 샐러드": [11, 12],
      "신선한 샐러드 보울": [13],
      "허브 비프 스튜": [14],
      "허브 비프 스튜1": [15],
      "허브 비프 스튜2": [1, 2],
      "허브 비프 스튜3": [0, 1, 2],
      "허브 비프 스튜4": [3, 4],
      "허브 비프 스튜5": [5, 6],
      "허브 비프 스튜6": [7, 8, 9],
      "허브 비프 스튜7": [10],
      "허브 비프 스튜8": [11, 12],
    };

    final designers = ref.read(designerProvider);
    final selectedDesigners = products.values
        .map((value) => value.map((e) => designers[e]).toList())
        .toList();

    return List.generate(
      products.length,
      (index) => ProductModel(
        id: index.toString(),
        name: products.keys.toList()[index],
        mainImageUrl: '${ImagePath.productDirectory}$index.png',
        ratingPoint: DataUtils.getRandomDouble(min: 4, range: 1),
        hours: '11:00 ~ 20:00',
        location: '서울특별시 종로구 세종대로 172',
        isLike: DataUtils.getRandomBool(),
        designers: selectedDesigners[index],
        categoryStatus: getCategoryStatus(index: index),
      ),
    );
  }

  CategoryStatus getCategoryStatus({
    required int index,
  }) {
    switch (index) {
      case >= 0 && < 4:
        return CategoryStatus.beauty;
      case >= 4 && < 8:
        return CategoryStatus.nail;
      case >= 8 && < 12:
        return CategoryStatus.eyebrow;
      case >= 12 && < 16:
        return CategoryStatus.waxing;
      default:
        return CategoryStatus.beauty;
    }
  }
}
