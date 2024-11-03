import 'package:flutter/material.dart';

class ProductCategoryBox extends StatelessWidget {
  const ProductCategoryBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: PopupMenuButton<String>(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16.0),
          ),
        ),
        position: PopupMenuPosition.under,
        color: Colors.white,
        itemBuilder: (context) {
          return [
            categoryItem('카테고리 선택', false),
            categoryItem('디지털 가전', true),
            categoryItem('생활용품', false),
          ];
        },
        onSelected: (value) {
          print(value);
        },
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(8),
          ),
          padding: EdgeInsets.all(10),
          child: Text(
            '카테고리 선택',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  PopupMenuItem<String> categoryItem(String text, bool selected) {
    return PopupMenuItem<String>(
      value: text,
      child: Text(
        text,
        style: TextStyle(
          fontWeight: selected ? FontWeight.bold : null,
          color: selected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
