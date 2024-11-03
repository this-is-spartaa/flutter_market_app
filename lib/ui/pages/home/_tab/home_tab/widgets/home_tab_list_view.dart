import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/widgets/product_list_item.dart';

class HomeTabListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView(
        children: [
          ProductListItem(),
        ],
      ),
    );
  }
}
