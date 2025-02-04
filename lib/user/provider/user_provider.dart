import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../common/const/image_path.dart';
import '../model/user_model.dart';

final userProvider = StateNotifierProvider<UserStateNotifier, UserModelBase>(
  (ref) => UserStateNotifier(),
);

class UserStateNotifier extends StateNotifier<UserModelBase> {
  UserStateNotifier() : super(UserModelLoading()) {
    initItems();
  }

  void updateInfo({
    required String name,
    required String phone,
    required String email,
  }) {
    state = (state as UserModel).copyWith(
      name: name,
      phone: phone,
      email: email,
    );
  }

  void updateRecentlyViewedItems({
    required String recentlyViewedItem,
  }) {
    final user = state as UserModel;
    if (user.recentlyViewedItems.contains(recentlyViewedItem)) {
      print(1);
      state = user.copyWith(recentlyViewedItems: [
        ...user.recentlyViewedItems
            .where((element) => element != recentlyViewedItem),
        recentlyViewedItem,
      ]);
    } else {
      print(2);
      state = user.copyWith(recentlyViewedItems: [
        ...user.recentlyViewedItems,
        recentlyViewedItem,
      ]);
    }
    print(3);

    print((state as UserModel).recentlyViewedItems);
  }

  void initItems() {
    state = UserModel(
      id: 0,
      email: 'beauty0603@naver.com',
      username: 'beauty0603',
      password: 'beauty0603',
      name: '배기훈',
      phone: '01012341234',
      profileImage: ImagePath.user,
      recentlyViewedItems: ['4', '5', '6'],
    );
  }
}
