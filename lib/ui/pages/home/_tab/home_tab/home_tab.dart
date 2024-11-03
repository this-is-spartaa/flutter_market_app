import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/widgets/home_tab_app_bar.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/widgets/home_tab_list_view.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Scaffold의 body영역을 사용하는것이기 때문에 사이즈 최대로 확장
    return SizedBox.expand(
      child: Column(
        children: [
          HomeTabAppBar(),
          HomeTabListView(),
        ],
      ),
    );
  }
}
