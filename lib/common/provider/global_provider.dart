import 'package:flutter_riverpod/flutter_riverpod.dart';


final isAutoLoginProvider = StateProvider<bool>((ref) => true);
//
// final isSelectedRating = StateProvider<bool>((ref) => true);
//
// final ratingProvider = StateProvider<List<RatingModel>>((ref) => [
//   RatingModel(
//     id: 0,
//     username: 'apply23',
//     ratingPoint: 5,
//     content: '가격이 비싸지 않은데 맛있네요!',
//     createAt: DateTime(2024, 5, 8),
//   ),
//   RatingModel(
//     id: 1,
//     username: 'tongtong',
//     ratingPoint: 5,
//     content: '주문이 계속 들어와 또 구매합니다. 감사합니다.',
//     createAt: DateTime(2024, 5, 3),
//   ),
//   RatingModel(
//     id: 2,
//     username: 'pint123',
//     ratingPoint: 4,
//     content: '치즈볼하면 프리미엄 견과류 치즈볼이죠.',
//     createAt: DateTime(2024, 5, 3),
//   ),
//   RatingModel(
//     id: 3,
//     username: 'thisis0811',
//     ratingPoint: 5,
//     content: '묶음 단위로 계산하면 괜찮은 상품 중에서 가장 저렴하네요. 상품 추천 드려요.',
//     createAt: DateTime(2024, 5, 2),
//   ),
//   RatingModel(
//     id: 4,
//     username: 'pressbell0808',
//     ratingPoint: 5,
//     content:
//     '안녕하세요! 엄청 좋은 상품이라 리뷰 남겨요!\n배송도 빠르고 상품, 포장상태 전부 마음에 드네요. 다음에도 계속 주문하겠습니다. 감사합니다!',
//     createAt: DateTime(2024, 4, 30),
//   ),
// ]);