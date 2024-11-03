import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_market_app/core/validator_utils.dart';
import 'package:flutter_market_app/ui/pages/product_write/widgets/product_category_box.dart';
import 'package:flutter_market_app/ui/pages/product_write/widgets/product_write_picture_area.dart';

class ProductWritePage extends StatefulWidget {
  @override
  State<ProductWritePage> createState() => _ProductWritePageState();
}

class _ProductWritePageState extends State<ProductWritePage> {
  final formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('내 물건 팔기'),
        ),
        body: Form(
          key: formKey,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            children: [
              ProductWritePictureArea(),
              const SizedBox(height: 20),
              ProductCategoryBox(),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(hintText: "상품명을 입력해주세요"),
                validator: ValidatorUtils.validatorTitle,
                controller: titleController,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "가격을 입력해주세요"),
                validator: ValidatorUtils.validatorTitle,
                controller: priceController,
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "상품 내용을 입력해주세요"),
                validator: ValidatorUtils.validatorTitle,
                controller: contentController,
                // 키보드 숫자 UI 나오게!
                keyboardType: TextInputType.number,
                // 모바일에서 블루투스 키보드로 글자 입력해도 안됨! 오직 숫자만!
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {},
                child: Text('작성 완료'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
