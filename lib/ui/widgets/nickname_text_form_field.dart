import 'package:flutter/material.dart';
import 'package:flutter_market_app/core/validator_utils.dart';

class NicknameTextFormField extends StatelessWidget {
  const NicknameTextFormField({super.key, required this.controller});
  final TextEditingController controller;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: "닉네임을 입력해주세요"),
      validator: ValidatorUtils.validatorNickname,
      controller: controller,
    );
  }
}
