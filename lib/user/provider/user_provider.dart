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

  void updateInfo({required String name, required String phone}) {
    state = (state as UserModel).copyWith(
      name: name,
      phone: phone,
    );
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
    );
  }
}
