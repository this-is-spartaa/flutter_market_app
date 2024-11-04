import 'package:flutter/material.dart';
import 'package:flutter_market_app/core/image_picker_helper.dart';
import 'package:flutter_market_app/ui/pages/join/join_view_model.dart';
import 'package:flutter_market_app/ui/pages/welcome/welcome_page.dart';
import 'package:flutter_market_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_market_app/ui/widgets/nickname_text_form_field.dart';
import 'package:flutter_market_app/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JoinPage extends StatefulWidget {
  JoinPage({required this.address});

  String address;
  @override
  State<JoinPage> createState() => _JoinPageState();
}

class _JoinPageState extends State<JoinPage> {
  final formKey = GlobalKey<FormState>();

  final nicknameController = TextEditingController();
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    nicknameController.dispose();
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void onJoin(WidgetRef ref) async {
    if (formKey.currentState?.validate() ?? false) {
      final result = await ref.read(joinViewModel.notifier).join(
            username: idController.text,
            password: pwController.text,
            nickname: nicknameController.text,
            addressFullName: widget.address,
          );

      // 비동기 작업 후 BuildContext 사용하려면 이 위젯이 여전히 화면에 있는지(mounted) 확인!
      if (result && mounted) {
        // 나중에 뷰모델 구현 지금은 페이지 연결만!
        // 로그인 성공 시 네이게이터 스택에 쌓여있는 페이지 모두 제거!
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return WelcomePage();
            },
          ),
          // 기존 Navigator Stack에 쌓여있는 MaterialPageRoute들을 인자로 넘겨서 차례대로 호출해줌.
          // 이때 페이지를 Stack에 남길지 여부를 리턴
          // true => 페이지쌓여있음
          // false => 페이지 Pop
          // 현재 스택에는 WelcomePage -> LoginPage로 쌓여있기 때문에
          // LoginPage Stack에 남길지 여부, WelcomePage 남길지 두번 호출함
          // 둘 다 pop할거기때문에 false
          (route) {
            // print(route);
            return false;
          },
        );
      }
    }
  }

  void onImageUpload(WidgetRef ref) async {
    final result = await ImagePickerHelper.pickImage();
    if (result != null) {
      await ref.read(joinViewModel.notifier).uploadImage(
            filename: result.filename,
            mimeType: result.mimeType,
            bytes: result.bytes,
          );
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Form(
            key: formKey,
            child: ListView(
              children: [
                Text(
                  "안녕하세요!\n아이디와 비밀번호로 가입해주세요.",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    final imageFile = ref.watch(joinViewModel);
                    return GestureDetector(
                      onTap: () => onImageUpload(ref),
                      // ListView 내에서 Container 내 Image 사용시 Align 으로 정렬 해줘야함
                      // Container 크기를 지정했더라도 Image 사용 시 ListView 내에서 확장됨
                      child: Align(
                        child: Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            shape: BoxShape.circle,
                          ),
                          child: imageFile != null
                              ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100),
                                  child: Image.network(
                                    imageFile.url,
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.person,
                                      size: 30,
                                    ),
                                    SizedBox(height: 2),
                                    Text(
                                      '프로필 사진',
                                      style: TextStyle(
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    );
                  },
                ),
                SizedBox(height: 20),
                IdTextFormField(controller: idController),
                SizedBox(height: 20),
                PwTextFormField(controller: pwController),
                SizedBox(height: 20),
                NicknameTextFormField(controller: nicknameController),
                SizedBox(height: 20),
                Consumer(
                  builder: (context, ref, child) {
                    return ElevatedButton(
                      onPressed: () => onJoin(ref),
                      child: Text("회원가입"),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
