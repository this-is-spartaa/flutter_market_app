import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/home_tap_view_model.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/widgets/product_list_item.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Consumer(
        builder: (context, ref, child) {
          final products = ref.watch(homeTabViewModel).products;
          return ListView.separated(
            itemCount: products.length,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            separatorBuilder: (context, index) => const Divider(height: 20),
            itemBuilder: (context, index) {
              return ProductListItem(products[index]);
            },
          );
        },
      ),
    );
  }
}
