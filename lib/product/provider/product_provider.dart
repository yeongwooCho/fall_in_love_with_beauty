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
    // final Map<String, List<int>> products = {
    //   '프레쉬 샐러드 보울': [0, 1, 2],
    //   '야외 핫팟 피에스타': [3, 4],
    //   "프레쉬 야채 플래터": [5, 6],
    //   "헬시 믹스 샐러드": [7, 8, 9],
    //   "비타민 가득 샐러드": [10],
    //   "그릴드 치킨 닭가슴살 샐러드": [11, 12],
    //   "신선한 샐러드 보울": [13],
    //   "허브 비프 스튜": [14],
    //   "허브 비프 스튜1": [15],
    //   "허브 비프 스튜2": [1, 2],
    //   "허브 비프 스튜3": [0, 1, 2],
    //   "허브 비프 스튜4": [3, 4],
    //   "허브 비프 스튜5": [5, 6],
    //   "허브 비프 스튜6": [7, 8, 9],
    //   "허브 비프 스튜7": [10],
    //   "허브 비프 스튜8": [11, 12],
    // };

    final names = [
      '고아라헤어케어 강남점',
      '르블라썸 강남점',
      '엥비떼헤어 신논현점',
      '살롱드라피네 선릉역점',
      '살롱드라피네 강남역사거리점',
      '벨꾸루헤어',
      '메이봄헤어 본점',
      '포레포레헤어 고속터미널점',
      '살롱드라피네 강남점',
      '스타일바이제이헤어 양재점',
      '르블라썸',
      '메종드 아이디헤어 반포',
      '에이그로우 신논현본점',
      '이철헤어커커 대치라운지',
      '무이 대치본점',
      '그로잉살롱 잠실점',
    ];
    final hours = [
      '10:30~22:00',
      '10:30~22:30',
      '11:00~22:00',
      '10:00~20:30',
      '10:00~21:00',
      '10:00~20:00',
      '10:00~21:30',
      '10:00~21:00',
      '10:00~20:00',
      '11:00~20:00',
      '10:00~21:00',
      '10:00~20:00',
      '10:00~21:30',
      '10:00~21:00',
      '10:00~20:00',
      '11:00~20:00',
    ];
    final locations = [
      '강남역 12번출구 바로 앞',
      '역삼역 3번출구에서 도보 300m 입니다.',
      '강남역11번.강남CGV뒷편 편의점에서 두블럭올라오셔서 왼쪽 올바른스시2층',
      '선릉역8번출구 바로앞',
      '강남역사거리 10번출구 앞',
      '언남고 후문',
      '양재역5번출구에서 1분',
      '강남고속터미널 경부선 지하1층(신세계팩토리스토어 옆)',
      '신논현역 4번출구 바로앞',
      '삼호물산 부근',
      '서울 강남구 논현로85길 43',
      '서울 서초구 고무래로 26 쌍동빌딩',
      '서울 강남구 강남대로118길 24 1층,2층 에이그로우',
      '서울 강남구 선릉로 324 SH타워',
      '서울 강남구 삼성로 314 보양빌딩 1층 무이 대치본점',
      '서울 송파구 올림픽로12길 36 2층 그로잉살롱 잠실점',
    ];

    final descriptions = [
      '1:1 맞춤 헤어 컨설팅을 추구하여 특별함을 느낄 수 있는 공간에서 감각적인 디자인을 제안하고 편안한 휴식을 제공하여 고객님의 행복함을 항상 생각합니다.\n\n저희 헤어원씽만의 노하우와 트랜디한 헤어스타일로 완벽한 1:1 맞춤 헤어 컨설팅을 고객님께 선사해 드리겠습니다.\n\n매월 1,2주 일요일 휴무\n매월 3,4주 화요일 휴무',
      '로레알 시세이도 서프라리스 100%정품 제품만을 사용하고 합리적인가격으로 오늘도 최선을 다하는 착한뷰티살롱입니다. 고객 한분 한분에게 진심을 담아 정성을 다하여 시술해드리도록 노력하겠습니다 펌 염색 상담시 모발의손상도에 따라 추가금액이 발생할 수 있습니다.',
      '*시술 특성상 다소 대기시간이 발생 될 수 있습니다 *예약 상담 문의는 카카오채널 검색에서 [벨꾸루헤어] 등록',
      '저희 모발에 시술한다는 생각을 손상도가 적은 펌제를 사용합니다.',
      '강남역 미용실 메이봄 헤어의 3가지 약속',
      '메이봄 헤어는 언제나 최고의 제품만을 사용할 것을 원칙으로 합니다.',
      '강남 최초 컬러바를 통해 고객이 원하는 색상 일체 구현을 약속합니다.',
      '최고의 스타일리스트들이 1:1 책임 시술로 숨어 있는 아름다움을 찾아드립니다.',
      '고객 한분 한분과의 만남을 소중히 여겨 최선의 만족을 드리겠습니다.',
      '한국의 기술력과 일본의 기술력으로 운영되어집니다.',
      '다양한 이벤트와 첫방문 할인 이벤트를 진행하고 있으며 분기마다 다른 할인 혜택도 함께 지원해드리고 있습니다.',
      '메이봄 헤어는 언제나 최고의 제품만을 사용할 것을 원칙으로 합니다.',
      '강남 최초 컬러바를 통해 고객이 원하는 색상 일체 구현을 약속합니다.',
      '최고의 스타일리스트들이 1:1 책임 시술로 숨어 있는 아름다움을 찾아드립니다.',
      '고객 한분 한분과의 만남을 소중히 여겨 최선의 만족을 드리겠습니다.',
      '한국의 기술력과 일본의 기술력으로 운영되어집니다.',
      '다양한 이벤트와 첫방문 할인 이벤트를 진행하고 있으며 분기마다 다른 할인 혜택도 함께 지원해드리고 있습니다.',
    ];

    final designers = ref.read(designerProvider);
    final selectedDesigners = [
      [0, 1, 2],
      [3, 4],
      [5, 6],
      [7, 8, 9],
      [10],
      [11, 12],
      [13],
      [14],
      [15],
      [1, 2],
      [0, 1, 2],
      [3, 4],
      [5, 6],
      [7, 8, 9],
      [10],
      [11, 12]
    ].map((value) => value.map((e) => designers[e]).toList()).toList();

    return List.generate(
      names.length,
      (index) => ProductModel(
        id: index.toString(),
        name: names[index],
        mainImageUrl: '${ImagePath.productDirectory}$index.png',
        ratingPoint: DataUtils.getRandomDouble(min: 4.7, range: 0.3),
        hours: hours[index],
        location: locations[index],
        description: descriptions[index],
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
