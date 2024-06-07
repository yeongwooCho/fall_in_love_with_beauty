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
    // final designers = {
    //   '김소진 원장': [0, 1, 2, 3],
    //   '이유진 원장': [4, 5, 6],
    //   '채리 원장': [7, 8, 9],
    //   '유빈 실장': [10, 11, 12],
    //   "하율 디자이너": [13, 14],
    //   "김유지 실장": [15, 16, 17],
    //   "이상현 실장": [18, 19],
    //   "김진 실장": [20, 21],
    //   "김유진 실장": [22, 23],
    //   "박혜린 실장": [0, 1, 2, 3],
    //   "주빈 디자이너": [4, 5, 6],
    //   "혜린 실장": [7, 8, 9],
    //   "민지 원장": [10],
    //   "소진 실장": [11, 12],
    //   "유리 실장": [13, 14],
    //   "성철 원장": [15, 16, 17],
    // };

    final designerName = [
      '부원장 백도경',
      '원장 장민',
      '디자이너 김세은',
      '실장 황서우',
      '원장 레이',
      '실장 성중',
      '류승연',
      '신영',
      '윤결',
      '지현',
      '원장 이유진',
      "실장 김진",
      "실장 박혜린",
      "디자이너 하율",
      '유리',
      "실장 박혜린",
    ];

    final resultImageUrls = [
      [0, 1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [10, 11, 12],
      [13, 14],
      [15, 16, 17],
      [18, 19],
      [20, 21],
      [22, 23],
      [0, 1, 2, 3],
      [4, 5, 6],
      [7, 8, 9],
      [10],
      [11, 12],
      [13, 14],
      [15, 16, 17],
    ];

    final thumbnails = [
      '카카오헤어샵 첫만남 이벤트 진행중(11년)',
      '트렌디하고 세련된 헤어 전문(10년)',
      '염색&탈색의 귀신 (10년)',
      '후헤어 대표(15년)',
      '1:1인생 디자이너(13년)',
      '복구매직 복구염색 복구클리닉 마스',
      '트렌드 스타일전문(4년)',
      '트렌드 컬러(9년)',
      '스타일전문(12년)',
      '일상이 행복해지는 디자인(13년)',
      '트렌디하고 세련된 헤어 전문(10년)',
      '후헤어 대표(15년)',
      '복구매직 복구염색 복구클리닉 마스',
      '트렌드 컬러(9년)',
      '스타일전문(12년)',
      '일상이 행복해지는 디자인(13년)',
    ];
    final description = [
      '작은 디테일에 따라 같은 스타일도 달라보입니다. 마음으로 다가가 숨겨져있는 아름다움까지 찾아 드리는 디자이너 김소진입니다.\n\n고객님의 두상과 모질을 정확히 판단하여 고객님만의 맞춤스타일을 만들어 드리겠습니다.',
      '1인 미용실의 장점을 최대한 살려 인턴 없이 1:1 원장 시술로 고객님의 만족도를 최대한 올려드리겠습니다',
      '경력과 실력은 물론 최신 트렌드 감각까지 겸비한 삼성역 최고의 디자이너!',
      '안녕하세요. 살롱 드 프레 카카오고객 첫만남 이벤트를 진행중입니다. 픽메뉴를 확인해주세요.',
      '개개인의 얼굴형,라이프스타일,꼼꼼한 상담으로 변신시켜드리겠습니다',
      '1:1 제가 직접 상담 시술 하여 처음부터 끝까지 고객님이 원하시는 스타일 만들어 드리도록 항상 최선을 다하겠습니다.',
      '한결같은 미소로 고객님을 맞이하는 따듯한 디자이너, 끝없이 노력하는 열정적인 디자이너, 여러분을 행복하게 하는 해피바이러스 고아라헤어케어 강남점 지혜디자이너 입니다. ^^',
      '고객님의 얼굴형에 맞는 성형컷',
      '봄처럼 산뜻 발랄한 헤어 컬러~',
      '봄꽃같은 헤어스타일링을 해드리겠습니다.',
      '펌,염색전문  각자의 매력을 찾아 빛나게 해드리겠습니다.',
      '안녕하세요. 살롱 드 프레 카카오고객 첫만남 이벤트를 진행중입니다. 픽메뉴를 확인해주세요.',
      '1:1 제가 직접 상담 시술 하여 처음부터 끝까지 고객님이 원하시는 스타일 만들어 드리도록 항상 최선을 다하겠습니다.',
      '고객님의 얼굴형에 맞는 성형컷',
      '봄처럼 산뜻 발랄한 헤어 컬러~',
      '봄꽃같은 헤어스타일링을 해드리겠습니다.',
    ];

    return List.generate(
      designerName.length,
      (index) => DesignerModel(
        id: index.toString(),
        name: designerName[index],
        thumbnail: thumbnails[index],
        mainImageUrl: '${ImagePath.designerDirectory}$index.png',
        ratingPoint: DataUtils.getRandomDouble(min: 4.7, range: 0.3),
        description: description[index],
        snsUrl: 'https://www.instagram.com/hairdrop/',
        isLike: DataUtils.getRandomBool(),
        resultImageUrls: resultImageUrls[index]
            .map((e) => '${ImagePath.resultDirectory}$e.png')
            .toList(),
      ),
    );
  }
}
