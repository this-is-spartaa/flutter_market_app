import 'package:flutter/material.dart';
import 'package:flutter_market_app/ui/pages/home/_tab/home_tab/home_tap_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomeTabAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // AppBar롤 Scaffold의 appBar 속성내에 사용하지 않을 경우 몇가지 제한사항이 있음
    // bottom 속성 등. 하지만 해당 속성을 사용하지 않을거기 때문에 사용
    return AppBar(
      title: Consumer(
        builder: (context, ref, child) {
          final addresses = ref.watch(homeTabViewModel).addresses;
          final targetAddresses = addresses.where(
            (e) => e.defaultYn ?? false,
          );
          return Text(
              targetAddresses.isEmpty ? '' : targetAddresses.first.displayName);
        },
      ),
      actions: [
        GestureDetector(
          onTap: () {
            print("search");
          },
          child: Container(
            width: 50,
            height: 50,
            color: Colors.transparent,
            child: Icon(Icons.search),
          ),
        ),
      ],
    );
  }
}
