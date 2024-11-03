import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/home_page.dart';
import 'package:flutter_market_app/ui/pages/login/login_view_model.dart';
import 'package:flutter_market_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_market_app/ui/widgets/pw_text_form_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  final idController = TextEditingController();
  final pwController = TextEditingController();

  @override
  void dispose() {
    idController.dispose();
    pwController.dispose();
    super.dispose();
  }

  void onLoginClick(WidgetRef ref) async {
    if (formKey.currentState?.validate() ?? false) {
      final result = await ref.read(loginViewModel).login(
            username: idController.text,
            password: pwController.text,
          );

      if (result && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) {
              return HomePage();
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
        List;
      } else if (!result && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('아이디와 비밀번호를 확인해 주세요'),
            showCloseIcon: true,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
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
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20),
            children: [
              Text(
                "안녕하세요!\n아이디와 비밀번호로 로그인해주세요",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              IdTextFormField(controller: idController),
              SizedBox(height: 20),
              PwTextFormField(controller: pwController),
              SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () => onLoginClick(ref),
                    child: Text("로그인"),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
