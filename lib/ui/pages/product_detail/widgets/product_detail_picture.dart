import 'package:flutter/material.dart';

class ProductDetailPicture extends StatelessWidget {
  const ProductDetailPicture({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      // 리스트뷰와 동일
      // 페이지 넘길 때 사용
      child: PageView.builder(
        itemCount: 3,
        itemBuilder: (context, index) {
          return Image.network(
            'https://picsum.photos/200/300',
            fit: BoxFit.cover,
          );
        },
      ),
    );
  }
}
