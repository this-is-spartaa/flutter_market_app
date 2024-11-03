import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/widgets/id_text_form_field.dart';
import 'package:flutter_market_app/ui/widgets/pw_text_form_field.dart';

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

  void onLoginClick() async {
    if (formKey.currentState?.validate() ?? false) {
      // 나중에 여기서 뷰모델 연동!
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
              ElevatedButton(
                onPressed: onLoginClick,
                child: Text("로그인"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
