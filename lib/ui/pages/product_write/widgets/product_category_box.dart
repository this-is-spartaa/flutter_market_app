import 'package:flutter/material.dart';
import 'package:flutter_market_app/data/model/product.dart';
import 'package:flutter_market_app/ui/pages/product_write/product_write_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductCategoryBox extends StatelessWidget {
  const ProductCategoryBox(this.product, {super.key});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, ref, child) {
        final state = ref.watch(productWriteViewModel(product));
        final vm = ref.read(productWriteViewModel(product).notifier);
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
              final categoryItems = state.categories.map(
                (e) {
                  return categoryItem(
                    e.category,
                    state.selectedCategory?.id == e.id,
                  );
                },
              );
              return [
                categoryItem('카테고리 선택', false),
                // 스프레드 연산자. 리스트안에 다른 리스트를 포함시킬 때
                ...categoryItems,
              ];
            },
            onSelected: vm.onCategorySelected,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.all(10),
              child: Text(
                state.selectedCategory?.category ?? '카테고리 선택',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ),
        );
      },
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
