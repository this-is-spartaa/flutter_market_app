import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_market_app/core/validator_utils.dart';
import 'package:flutter_market_app/data/model/product.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/home_tap_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_detail/product_detail_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_write/product_write_view_model.dart';
import 'package:flutter_market_app/ui/pages/product_write/widgets/product_category_box.dart';
import 'package:flutter_market_app/ui/pages/product_write/widgets/product_write_picture_area.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductWritePage extends StatefulWidget {
  const ProductWritePage(this.product);

  final Product? product;

  @override
  State<ProductWritePage> createState() => _ProductWritePageState();
}

class _ProductWritePageState extends State<ProductWritePage> {
  final formKey = GlobalKey<FormState>();
  late final titleController =
      TextEditingController(text: widget.product?.title);
  late final priceController =
      TextEditingController(text: widget.product?.price.toString());
  late final contentController =
      TextEditingController(text: widget.product?.content);

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
              ProductWritePictureArea(widget.product),
              const SizedBox(height: 20),
              ProductCategoryBox(widget.product),
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
                // 키보드 숫자 UI 나오게!
                keyboardType: TextInputType.number,
                // 모바일에서 블루투스 키보드로 글자 입력해도 안됨! 오직 숫자만!
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              ),
              const SizedBox(height: 20),
              TextFormField(
                decoration: InputDecoration(hintText: "상품 내용을 입력해주세요"),
                validator: ValidatorUtils.validatorTitle,
                controller: contentController,
              ),
              const SizedBox(height: 20),
              Consumer(
                builder: (context, ref, child) {
                  return ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState?.validate() ?? false) {
                        final vm = ref.read(
                            productWriteViewModel(widget.product).notifier);
                        final result = await vm.upload(
                          title: titleController.text,
                          content: contentController.text,
                          price: int.parse(priceController.text),
                        );

                        if (result != null) {
                          ref.read(homeTabViewModel.notifier).fetchProducts();
                          if (widget.product != null) {
                            ref
                                .read(productDetailViewModel(widget.product!.id)
                                    .notifier)
                                .fetchDetail();
                          }
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text('작성 완료'),
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
