import 'package:fall_in_love_with_beauty/common/const/image_path.dart';
import 'package:fall_in_love_with_beauty/common/utils/data_utils.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../model/designer_model.dart';

// final designerWithRandomProvider = Provider<List<DesignerModel>>((ref) {
//   final designers = ref.watch(designerProvider);
//   final shuffledDesigners = DataUtils.getRandomShuffledList(designers);
//   return shuffledDesigners.take(3).toList();
// });

final designersWithLikeProvider = Provider<List<DesignerModel>>((ref) {
  final designers = ref.watch(designerProvider);
  return designers.where((element) => element.isLike).toList();
});

final designerDetailProvider =
    Provider.family<DesignerModel, String>((ref, id) {
  final designer =
      ref.watch(designerProvider).firstWhere((element) => element.id == id);
  return designer;
});

final designerProvider =
    StateNotifierProvider<DesignerStateNotifier, List<DesignerModel>>((ref) {
  return DesignerStateNotifier();
});

class DesignerStateNotifier extends StateNotifier<List<DesignerModel>> {
  DesignerStateNotifier() : super([]) {
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

  List<DesignerModel> getItems() {
    final designers = {
      '김소진 원장': [0, 1],
      '이유진 원장': [3, 4],
      '채리 원장': [5],
      '유빈 실장': [6],
      "하율 디자이너": [7, 8],
      "김유지 실장": [9],
      "이상현 실장": [10, 11],
      "김진 실장": [12, 13],
      "김유진 실장": [14, 2],
      "박혜린 실장": [1, 2, 3],
      "주빈 디자이너": [4, 5, 6],
      "혜린 실장": [7],
      "민지 원장": [8],
      "소진 실장": [9],
      "유리 실장": [10],
      "성철 원장": [11],
    };

    return List.generate(
      designers.length,
      (index) => DesignerModel(
        id: index.toString(),
        name: designers.keys.toList()[index],
        thumbnail: '펌 전문 디자이너[12년]',
        mainImageUrl: '${ImagePath.designerDirectory}$index.png',
        ratingPoint: DataUtils.getRandomDouble(min: 4, range: 1),
        description: '작은 디테일에 따라 같은 스타일도 달라보입니다. 마음으로 다가가 숨겨져있는 아름다움까지 찾아 드리는 디자이너 김소진입니다.\n\n고객님의 두상과 모질을 정확히 판단하여 고객님만의 맞춤스타일을 만들어 드리겠습니다.',
        snsUrl: 'https://www.instagram.com/hairdrop/',
        isLike: DataUtils.getRandomBool(),
        resultImageUrls: designers.values
            .toList()[index]
            .map((e) => '${ImagePath.resultDirectory}$e.png')
            .toList(),
      ),
    );
  }
}
