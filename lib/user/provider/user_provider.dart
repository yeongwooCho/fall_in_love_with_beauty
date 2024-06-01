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
      id: 1,
      email: 'tower0601@naver.com',
      username: 'tower0601',
      password: 'tower',
      name: '김준혁',
      phone: '01012341234',
      profileImage: ImagePath.user,
    );
  }
}
