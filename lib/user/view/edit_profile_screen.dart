import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../common/component/custom_text_form_field.dart';
import '../../common/component/default_button.dart';
import '../../common/component/show/show_custom_toast.dart';
import '../../common/const/colors.dart';
import '../../common/const/image_path.dart';
import '../../common/const/text_styles.dart';
import '../../common/layout/default_app_bar.dart';
import '../../common/layout/default_layout.dart';
import '../model/user_model.dart';
import '../provider/user_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  static String get routeName => "edit_profile";

  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  List<String> selectedDropdownItems = [];

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);

    if (user is UserModel) {
      _usernameController.text = user.username;
      _nameController.text = user.name;
      _phoneController.text = user.phone;
    }

    return DefaultLayout(
      appbar: const DefaultAppBar(title: '내 정보 수정'),
      child: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 20.0,
          ),
          child: Container(
            color: MyColor.empty,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    '프로필 사진',
                    style: MyTextStyle.bodyTitleMedium,
                  ),
                ),
                const SizedBox(height: 8.0),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset(
                      ImagePath.user,
                      width: 120.0,
                      height: 120.0,
                    ),
                    const SizedBox(width: 16.0),
                    SecondaryButton(
                      onPressed: () {},
                      child: Text('프로필 사진 변경'),
                    ),
                  ],
                ),
                const SizedBox(height: 40.0),
                const Padding(
                  padding: EdgeInsets.only(left: 4.0),
                  child: Text(
                    '회원정보',
                    style: MyTextStyle.bodyTitleMedium,
                  ),
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: _usernameController,
                  onChanged: (String? value) {},
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                  enabled: false,
                ),
                const SizedBox(height: 4.0),
                Text(
                  '아이디는 변경할 수 없습니다.',
                  style: MyTextStyle.minimumRegular.copyWith(
                    color: MyColor.darkGrey,
                  ),
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: _nameController,
                  onChanged: (String? value) {},
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  controller: _phoneController,
                  onChanged: (String? value) {},
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  hintText: '비밀번호(영문, 숫자, 특수문자 합 8~15자)',
                  onChanged: (String? value) {},
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 8.0),
                CustomTextFormField(
                  hintText: '비밀번호 확인',
                  onChanged: (String? value) {},
                  onSaved: (String? value) {},
                  validator: (String? value) {
                    return null;
                  },
                  textInputType: TextInputType.number,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 40.0,
                  ),
                  child: PrimaryButton(
                    onPressed: () {
                      ref.read(userProvider.notifier).updateInfo(
                            name: _nameController.text,
                            phone: _phoneController.text,
                          );

                      showCustomToast(context, msg: '저장이 완료되었습니다.');
                      context.pop();
                    },
                    child: const Text('변경하기'),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
